import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as p;
import '../../domain/entities/education.dart';
import '../models/education_model.dart';

abstract class EducationRemoteDataSource {
  Future<List<EducationModel>> getEducations();
  Future<void> addEducation(Education education);
  Future<void> updateEducation(Education education);
  Future<void> deleteEducation(String id);
}

@LazySingleton(as: EducationRemoteDataSource)
class EducationRemoteDataSourceImpl implements EducationRemoteDataSource {
  final SupabaseClient _supabase;

  EducationRemoteDataSourceImpl(this._supabase);

  String get _userId => _supabase.auth.currentUser!.id;

  @override
  Future<List<EducationModel>> getEducations() async {
    final response = await _supabase
        .from('educations')
        .select()
        .eq('user_id', _userId)
        .order('start_date', ascending: false);

    return (response as List)
        .map((e) => EducationModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> addEducation(Education education) async {
    String? gradCertUrl;
    String? academicRecUrl;

    if (education.graduationCertificateBytes != null) {
      gradCertUrl = await _uploadFileBytes(
        education.graduationCertificateBytes!,
        education.graduationCertificateName ?? 'grad_cert.pdf',
        'grad_cert_${DateTime.now().millisecondsSinceEpoch}',
      );
    }

    if (education.academicRecordBytes != null) {
      academicRecUrl = await _uploadFileBytes(
        education.academicRecordBytes!,
        education.academicRecordName ?? 'academic_rec.pdf',
        'academic_rec_${DateTime.now().millisecondsSinceEpoch}',
      );
    }

    final model = EducationModel(
      id: '',
      degreeType: education.degreeType,
      institutionName: education.institutionName,
      fieldOfStudy: education.fieldOfStudy,
      startDate: education.startDate,
      endDate: education.endDate,
      gpa: education.gpa,
      activities: education.activities,
      graduationCertificateUrl: gradCertUrl,
      academicRecordUrl: academicRecUrl,
    );

    final data = model.toJson(userId: _userId);
    data.remove('id');

    await _supabase.from('educations').insert(data);
  }

  @override
  Future<void> updateEducation(Education education) async {
    String? gradCertUrl = education.graduationCertificateUrl;
    String? academicRecUrl = education.academicRecordUrl;

    if (education.graduationCertificateBytes != null) {
      if (gradCertUrl != null) await _deleteFile(gradCertUrl);

      gradCertUrl = await _uploadFileBytes(
        education.graduationCertificateBytes!,
        education.graduationCertificateName ?? 'grad_cert.pdf',
        'grad_cert_${DateTime.now().millisecondsSinceEpoch}',
      );
    }

    if (education.academicRecordBytes != null) {
      if (academicRecUrl != null) await _deleteFile(academicRecUrl);

      academicRecUrl = await _uploadFileBytes(
        education.academicRecordBytes!,
        education.academicRecordName ?? 'academic_rec.pdf',
        'academic_rec_${DateTime.now().millisecondsSinceEpoch}',
      );
    }

    final model = EducationModel(
      id: education.id,
      degreeType: education.degreeType,
      institutionName: education.institutionName,
      fieldOfStudy: education.fieldOfStudy,
      startDate: education.startDate,
      endDate: education.endDate,
      gpa: education.gpa,
      activities: education.activities,
      graduationCertificateUrl: gradCertUrl,
      academicRecordUrl: academicRecUrl,
    );

    final data = model.toJson(userId: _userId);
    data.remove('user_id');

    await _supabase.from('educations').update(data).eq('id', education.id);
  }

  @override
  Future<void> deleteEducation(String id) async {
    final response = await _supabase
        .from('educations')
        .select()
        .eq('id', id)
        .maybeSingle();

    if (response == null) {
      debugPrint("Education record with id $id not found or already deleted.");
      return;
    }

    final education = EducationModel.fromJson(response);

    if (education.graduationCertificateUrl != null) {
      await _deleteFile(education.graduationCertificateUrl!);
    }
    if (education.academicRecordUrl != null) {
      await _deleteFile(education.academicRecordUrl!);
    }

    await _supabase.from('educations').delete().eq('id', id);
  }

  Future<String> _uploadFileBytes(
    Uint8List bytes,
    String originalFileName,
    String fileNamePrefix,
  ) async {
    final fileExt = p.extension(originalFileName);
    final fileName = '$fileNamePrefix$fileExt';
    final filePath = '$_userId/$fileName';

    await _supabase.storage
        .from('education_files')
        .uploadBinary(
          filePath,
          bytes,
          fileOptions: const FileOptions(upsert: true),
        );

    final url = _supabase.storage
        .from('education_files')
        .getPublicUrl(filePath);
    return url;
  }

  Future<void> _deleteFile(String url) async {
    try {
      final uri = Uri.parse(url);
      final pathSegments = uri.pathSegments;

      final bucketIndex = pathSegments.indexOf('education_files');
      if (bucketIndex != -1 && bucketIndex + 1 < pathSegments.length) {
        final filePath = pathSegments.sublist(bucketIndex + 1).join('/');
        await _supabase.storage.from('education_files').remove([filePath]);
      }
    } catch (e) {
      debugPrint('Error deleting file: $e');
    }
  }
}
