// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'education.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Education _$EducationFromJson(Map<String, dynamic> json) => _Education(
  id: json['id'] as String,
  degreeType: json['degreeType'] as String? ?? '',
  institutionName: json['institutionName'] as String? ?? '',
  fieldOfStudy: json['fieldOfStudy'] as String? ?? '',
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: DateTime.parse(json['endDate'] as String),
  gpa: json['gpa'] as String?,
  activities:
      (json['activities'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  graduationCertificateBytes: const Uint8ListConverter().fromJson(
    json['graduationCertificateBytes'] as String?,
  ),
  graduationCertificateName: json['graduationCertificateName'] as String?,
  academicRecordBytes: const Uint8ListConverter().fromJson(
    json['academicRecordBytes'] as String?,
  ),
  academicRecordName: json['academicRecordName'] as String?,
  graduationCertificateUrl: json['graduationCertificateUrl'] as String?,
  academicRecordUrl: json['academicRecordUrl'] as String?,
);

Map<String, dynamic> _$EducationToJson(_Education instance) =>
    <String, dynamic>{
      'id': instance.id,
      'degreeType': instance.degreeType,
      'institutionName': instance.institutionName,
      'fieldOfStudy': instance.fieldOfStudy,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'gpa': instance.gpa,
      'activities': instance.activities,
      'graduationCertificateBytes': const Uint8ListConverter().toJson(
        instance.graduationCertificateBytes,
      ),
      'graduationCertificateName': instance.graduationCertificateName,
      'academicRecordBytes': const Uint8ListConverter().toJson(
        instance.academicRecordBytes,
      ),
      'academicRecordName': instance.academicRecordName,
      'graduationCertificateUrl': instance.graduationCertificateUrl,
      'academicRecordUrl': instance.academicRecordUrl,
    };
