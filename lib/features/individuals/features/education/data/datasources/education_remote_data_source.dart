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
    // 1. Fetch the CURRENT state from the database to check for existing files
    final currentRecord = await _supabase
        .from('educations')
        .select()
        .eq('id', education.id)
        .single();

    final String? oldGradUrl = currentRecord['graduation_certificate_url'];
    final String? oldAcademicUrl = currentRecord['academic_record_url'];

    // 2. Prepare new URLs
    String? gradCertUrl = education.graduationCertificateUrl;
    String? academicRecUrl = education.academicRecordUrl;

    // --- HANDLE GRADUATION CERTIFICATE ---

    // Case A: User selected a NEW file (bytes are present).
    // We must upload the new one. If there was an old one, delete it.
    if (education.graduationCertificateBytes != null) {
      // If there was an old file, delete it from storage
      if (oldGradUrl != null) await _deleteFile(oldGradUrl);

      gradCertUrl = await _uploadFileBytes(
        education.graduationCertificateBytes!,
        education.graduationCertificateName ?? 'grad_cert.pdf',
        'grad_cert_${DateTime.now().millisecondsSinceEpoch}',
      );
    } 
    // Case B: User clicked "X" (Bytes are null AND Url is null).
    // If there was an old file, we must delete it from storage.
    else if (education.graduationCertificateUrl == null && oldGradUrl != null) {
      await _deleteFile(oldGradUrl);
      gradCertUrl = null; // Ensure DB clears this field
    }
    // Case C: User did nothing. education.graduationCertificateUrl is preserved from the modal state.
    // We do nothing to storage.

    // --- HANDLE ACADEMIC RECORD (Same Logic) ---
    
    if (education.academicRecordBytes != null) {
      if (oldAcademicUrl != null) await _deleteFile(oldAcademicUrl);

      academicRecUrl = await _uploadFileBytes(
        education.academicRecordBytes!,
        education.academicRecordName ?? 'academic_rec.pdf',
        'academic_rec_${DateTime.now().millisecondsSinceEpoch}',
      );
    } else if (education.academicRecordUrl == null && oldAcademicUrl != null) {
      await _deleteFile(oldAcademicUrl);
      academicRecUrl = null;
    }

    // 3. Update the Database
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
    data.remove('user_id'); // Don't update user_id

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
