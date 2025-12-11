// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'education.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Education _$EducationFromJson(Map<String, dynamic> json) => _Education(
  id: json['id'] as String,
  degreeType: json['degree_type'] as String? ?? '',
  institutionName: json['institution_name'] as String? ?? '',
  fieldOfStudy: json['field_of_study'] as String? ?? '',
  startDate: DateTime.parse(json['start_date'] as String),
  endDate: DateTime.parse(json['end_date'] as String),
  gpa: json['gpa'] as String?,
  activities:
      (json['activities'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  graduationCertificateUrl: json['graduation_certificate_url'] as String?,
  academicRecordUrl: json['academic_record_url'] as String?,
);

Map<String, dynamic> _$EducationToJson(_Education instance) =>
    <String, dynamic>{
      'id': instance.id,
      'degree_type': instance.degreeType,
      'institution_name': instance.institutionName,
      'field_of_study': instance.fieldOfStudy,
      'start_date': instance.startDate.toIso8601String(),
      'end_date': instance.endDate.toIso8601String(),
      'gpa': instance.gpa,
      'activities': instance.activities,
      'graduation_certificate_url': instance.graduationCertificateUrl,
      'academic_record_url': instance.academicRecordUrl,
    };
