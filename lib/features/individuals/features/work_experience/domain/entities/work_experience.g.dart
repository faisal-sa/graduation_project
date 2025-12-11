// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_experience.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WorkExperience _$WorkExperienceFromJson(Map<String, dynamic> json) =>
    _WorkExperience(
      id: json['id'] as String,
      jobTitle: json['jobTitle'] as String? ?? '',
      companyName: json['companyName'] as String? ?? '',
      employmentType: json['employmentType'] as String? ?? '',
      location: json['location'] as String? ?? '',
      responsibilities:
          (json['responsibilities'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      isCurrentlyWorking: json['isCurrentlyWorking'] as bool? ?? false,
    );

Map<String, dynamic> _$WorkExperienceToJson(_WorkExperience instance) =>
    <String, dynamic>{
      'id': instance.id,
      'jobTitle': instance.jobTitle,
      'companyName': instance.companyName,
      'employmentType': instance.employmentType,
      'location': instance.location,
      'responsibilities': instance.responsibilities,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'isCurrentlyWorking': instance.isCurrentlyWorking,
    };
