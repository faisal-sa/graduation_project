
import 'package:graduation_project/features/individuals/features/certifications/domain/entities/certification.dart';
import 'package:graduation_project/features/individuals/features/education/domain/entities/education.dart';
import 'package:graduation_project/features/individuals/features/job_preferences/domain/entities/job_preferences_entity.dart';
import 'package:graduation_project/features/individuals/features/work_experience/domain/entities/work_experience.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

part 'user_entity.g.dart';

@freezed
abstract class UserEntity with _$UserEntity {
  const factory UserEntity({
    @Default('') String firstName,
    @Default('') String lastName,
    @Default('') String jobTitle,
    @Default('') String phoneNumber,
    @Default('') String email,
    @Default('') String location,
    @Default('') String summary,
    String? videoUrl,
    String? avatarUrl,
    @Default([]) List<WorkExperience> workExperiences,
    @Default([]) List<Education> educations,
    @Default([]) List<Certification> certifications,
    @Default([]) List<String> skills,
    @Default([]) List<String> languages,
    @Default(JobPreferencesEntity()) JobPreferencesEntity jobPreferences,
  }) = _UserEntity;

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);
}
