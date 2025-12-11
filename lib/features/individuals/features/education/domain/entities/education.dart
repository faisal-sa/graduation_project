import 'dart:typed_data';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduation_project/core/utils/json_converters.dart';

part 'education.freezed.dart';
part 'education.g.dart';

@freezed
abstract class Education with _$Education {
  const factory Education({
    required String id,
    @Default('') String degreeType,
    @Default('') String institutionName,
    @Default('') String fieldOfStudy,
    required DateTime startDate,
    required DateTime endDate,
    String? gpa,
    @Default([]) List<String> activities,
    
    // Custom converter for Base64 <-> Uint8List
    @Uint8ListConverter() Uint8List? graduationCertificateBytes,
    String? graduationCertificateName,
    
    @Uint8ListConverter() Uint8List? academicRecordBytes,
    String? academicRecordName,
    
    String? graduationCertificateUrl,
    String? academicRecordUrl,
  }) = _Education;

  factory Education.fromJson(Map<String, dynamic> json) =>
      _$EducationFromJson(json);
}
