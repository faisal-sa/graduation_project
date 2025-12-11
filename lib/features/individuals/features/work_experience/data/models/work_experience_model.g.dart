// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_experience_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WorkExperienceModel _$WorkExperienceModelFromJson(Map<String, dynamic> json) =>
    _WorkExperienceModel(
      id: json['id'] as String,
      jobTitle: json['job_title'] as String,
      companyName: json['company_name'] as String,
      employmentType: json['employment_type'] as String,
      location: json['location'] as String,
      responsibilities:
          (json['responsibilities'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
      isCurrentlyWorking: json['is_currently_working'] as bool? ?? false,
    );

Map<String, dynamic> _$WorkExperienceModelToJson(
  _WorkExperienceModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'job_title': instance.jobTitle,
  'company_name': instance.companyName,
  'employment_type': instance.employmentType,
  'location': instance.location,
  'responsibilities': instance.responsibilities,
  'start_date': instance.startDate.toIso8601String(),
  'end_date': instance.endDate?.toIso8601String(),
  'is_currently_working': instance.isCurrentlyWorking,
};
