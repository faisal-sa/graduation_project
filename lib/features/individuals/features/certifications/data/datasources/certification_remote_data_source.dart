import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/certification_model.dart';

abstract class CertificationRemoteDataSource {
  Future<List<CertificationModel>> getCertifications();
  Future<void> addCertification(CertificationModel model);
  Future<void> updateCertification(CertificationModel model);
  Future<void> deleteCertification(String id);
  Future<String> uploadCredentialFile(File file, String userId);
}

@LazySingleton(as: CertificationRemoteDataSource)
class CertificationRemoteDataSourceImpl
    implements CertificationRemoteDataSource {
  final SupabaseClient _client;

  CertificationRemoteDataSourceImpl(this._client);

  @override
  Future<List<CertificationModel>> getCertifications() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) throw Exception("User not authenticated");

    final response = await _client
        .from('certifications')
        .select()
        .eq('user_id', userId)
        .order('issue_date', ascending: false);

    return (response as List)
        .map((e) => CertificationModel.fromJson(e))
        .toList();
  }

  @override
  Future<void> addCertification(CertificationModel model) async {
    // We remove 'id' from toJson if it's empty so Postgres gen_random_uuid() triggers,
    // OR we generate a UUID in the domain layer.
    // Assuming Domain generates UUID or we let DB handle it.
    // Let's rely on map sanitization:
    final data = model.toJson();
    if (model.id.isEmpty) {
      data.remove('id');
    }

    await _client.from('certifications').insert(data);
  }

  @override
  Future<void> updateCertification(CertificationModel model) async {
    await _client
        .from('certifications')
        .update(model.toJson())
        .eq('id', model.id);
  }

  @override
  Future<void> deleteCertification(String id) async {
    await _client.from('certifications').delete().eq('id', id);
  }

  @override
  Future<String> uploadCredentialFile(File file, String userId) async {
    final fileExt = file.path.split('.').last;
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.$fileExt';
    final filePath = '$userId/$fileName';

    await _client.storage.from('certification_files').upload(filePath, file);

    final publicUrl = _client.storage
        .from('certification_files')
        .getPublicUrl(filePath);

    return publicUrl;
  }
}
