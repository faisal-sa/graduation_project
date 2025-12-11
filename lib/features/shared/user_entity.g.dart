// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => _UserEntity(
  firstName: json['first_name'] as String? ?? '',
  lastName: json['last_name'] as String? ?? '',
  jobTitle: json['job_title'] as String? ?? '',
  phoneNumber: json['phone_number'] as String? ?? '',
  email: json['email'] as String? ?? '',
  location: json['location'] as String? ?? '',
  summary: json['about_me'] as String? ?? '',
  videoUrl: json['intro_video_url'] as String?,
  avatarUrl: json['avatar_url'] as String?,
  workExperiences:
      (json['work_experiences'] as List<dynamic>?)
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
  jobPreferences: _readRoot(json, 'job_preferences') == null
      ? const JobPreferencesEntity()
      : JobPreferencesEntity.fromJson(
          _readRoot(json, 'job_preferences') as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$UserEntityToJson(
  _UserEntity instance,
) => <String, dynamic>{
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'job_title': instance.jobTitle,
  'phone_number': instance.phoneNumber,
  'email': instance.email,
  'location': instance.location,
  'about_me': instance.summary,
  'intro_video_url': instance.videoUrl,
  'avatar_url': instance.avatarUrl,
  'work_experiences': instance.workExperiences.map((e) => e.toJson()).toList(),
  'educations': instance.educations.map((e) => e.toJson()).toList(),
  'certifications': instance.certifications.map((e) => e.toJson()).toList(),
  'skills': instance.skills,
  'languages': instance.languages,
  'job_preferences': instance.jobPreferences.toJson(),
};
