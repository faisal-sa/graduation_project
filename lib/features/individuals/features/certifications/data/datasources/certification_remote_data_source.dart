import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/certification_model.dart';

abstract class CertificationRemoteDataSource {
  Future<List<CertificationModel>> getCertifications();
  Future<CertificationModel> addCertification(CertificationModel model);
  Future<void> updateCertification(CertificationModel model);
  Future<void> deleteCertification(String id);
  Future<String> uploadCredentialFile(File file, String userId);
}

@LazySingleton(as: CertificationRemoteDataSource)
class CertificationRemoteDataSourceImpl
    implements CertificationRemoteDataSource {
  final SupabaseClient _client;
  static const String _bucketName = 'certification_files';

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
  Future<CertificationModel> addCertification(CertificationModel model) async {
    final data = model.toJson();
    // Remove ID so Postgres generates a new UUID
    if (model.id.isEmpty) {
      data.remove('id');
    }

    // select().single() returns the inserted row with the new generated ID
    final response = await _client
        .from('certifications')
        .insert(data)
        .select()
        .single();

    return CertificationModel.fromJson(response);
  }

  @override
  Future<void> updateCertification(
    CertificationModel model, {
    File? newFile,
  }) async {
    CertificationModel modelToUpdate = model;

    // If a new file is provided, we need to swap the old file for the new one
    if (newFile != null) {
      // 1. Fetch the CURRENT database record to get the OLD URL
      final oldRecord = await _client
          .from('certifications')
          .select('credential_url')
          .eq('id', model.id)
          .single();

      final String? oldUrl = oldRecord['credential_url'];

      // 2. Upload the NEW file
      final userId = _client.auth.currentUser!.id;
      final newUrl = await uploadCredentialFile(newFile, userId);

      // 3. Update the model object using copyWith
      // This creates a new object with the new URL, keeping all other data the same
      modelToUpdate = model.copyWith(credentialUrl: newUrl);

      // 4. Delete the OLD file from storage (cleanup)
      if (oldUrl != null) {
        final oldPath = _extractPathFromUrl(oldUrl);
        if (oldPath != null) {
          await _client.storage.from(_bucketName).remove([oldPath]);
        }
      }
    }

    // 5. Update Database with the updated model
    await _client
        .from('certifications')
        .update(modelToUpdate.toJson())
        .eq('id', modelToUpdate.id);
  }
  @override
  Future<void> deleteCertification(String id) async {
    try {
      // 1. Fetch the record to get the URL
      final record = await _client
          .from('certifications')
          .select('credential_url')
          .eq('id', id)
          .single();

      final String? fileUrl = record['credential_url'];

      // 2. Delete from Storage FIRST
      if (fileUrl != null && fileUrl.isNotEmpty) {
        final path = _extractPathFromUrl(fileUrl);

        if (path != null) {
          // Attempt removal.
          // Note: If this fails due to RLS, it might not throw,
          // so ensure Step 1 (RLS) is applied correctly.
          final List<FileObject> result = await _client.storage
              .from(_bucketName)
              .remove([path]);

          // Optional debug: check if result is empty
          if (result.isEmpty) {
            print(
              'Warning: Storage file deletion returned empty. Check Path: $path or RLS policies.',
            );
          }
        }
      }

      // 3. Only after storage logic runs, delete the DB record
      await _client.from('certifications').delete().eq('id', id);
      
    } catch (e) {
      // If DB delete fails, the file is already gone (unfortunate but rare inconsistency).
      // If Storage delete throws, the DB row is preserved (good).
      throw Exception("Error deleting certification: $e");
    }
  }

  String? _extractPathFromUrl(String url) {
    try {
      final uri = Uri.parse(url);
      final segments = uri.pathSegments;
      final bucketIndex = segments.indexOf(_bucketName);

      if (bucketIndex != -1 && bucketIndex < segments.length - 1) {
        // 1. Extract the path after the bucket name
        final rawPath = segments.sublist(bucketIndex + 1).join('/');

        // 2. Decode the URI component (Important!)
        // Supabase URLs might encode spaces as %20.
        // The storage.remove() function expects "file name.pdf", not "file%20name.pdf"
        return Uri.decodeComponent(rawPath);
      }
      return null;
    } catch (e) {
      print("Error parsing URL: $e");
      return null;
    }
  }

  @override
  Future<String> uploadCredentialFile(File file, String userId) async {
    final fileExt = file.path.split('.').last;
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.$fileExt';
    final filePath = '$userId/$fileName';

    await _client.storage.from(_bucketName).upload(filePath, file);

    final publicUrl = _client.storage
        .from(_bucketName)
        .getPublicUrl(filePath);

    return publicUrl;
  }

 
}
