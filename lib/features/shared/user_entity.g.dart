// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => _UserEntity(
  firstName: json['firstName'] as String? ?? '',
  lastName: json['lastName'] as String? ?? '',
  jobTitle: json['jobTitle'] as String? ?? '',
  phoneNumber: json['phoneNumber'] as String? ?? '',
  email: json['email'] as String? ?? '',
  location: json['location'] as String? ?? '',
  summary: json['summary'] as String? ?? '',
  videoUrl: json['videoUrl'] as String?,
  avatarUrl: json['avatarUrl'] as String?,
  workExperiences:
      (json['workExperiences'] as List<dynamic>?)
          ?.map((e) => WorkExperience.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  educations:
      (json['educations'] as List<dynamic>?)
          ?.map((e) => Education.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  certifications:
      (json['certifications'] as List<dynamic>?)
          ?.map((e) => Certification.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  skills:
      (json['skills'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  languages:
      (json['languages'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  jobPreferences: json['jobPreferences'] == null
      ? const JobPreferencesEntity()
      : JobPreferencesEntity.fromJson(
          json['jobPreferences'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$UserEntityToJson(_UserEntity instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'jobTitle': instance.jobTitle,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'location': instance.location,
      'summary': instance.summary,
      'videoUrl': instance.videoUrl,
      'avatarUrl': instance.avatarUrl,
      'workExperiences': instance.workExperiences,
      'educations': instance.educations,
      'certifications': instance.certifications,
      'skills': instance.skills,
      'languages': instance.languages,
      'jobPreferences': instance.jobPreferences,
    };
