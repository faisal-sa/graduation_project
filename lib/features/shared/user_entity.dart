
import 'package:graduation_project/features/individuals/features/certifications/domain/entities/certification.dart';
import 'package:graduation_project/features/individuals/features/education/domain/entities/education.dart';
import 'package:graduation_project/features/individuals/features/job_preferences/domain/entities/job_preferences_entity.dart';
import 'package:graduation_project/features/individuals/features/work_experience/domain/entities/work_experience.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

part 'user_entity.g.dart';

// 1. Define this helper function outside the class
// It tells the parser: "Ignore the key 'jobPreferences', take the WHOLE JSON map instead."
Object? _readRoot(Map<dynamic, dynamic> json, String key) => json;

@freezed
abstract class UserEntity with _$UserEntity {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory UserEntity({
    @Default('') String firstName,
    @Default('') String lastName,
    @Default('') String jobTitle,
    @Default('') String phoneNumber,
    @Default('') String email,
    @Default('') String location,
    
    // Ensure all keys match DB columns or use @JsonKey
    @JsonKey(name: 'about_me') @Default('') String summary,
    @JsonKey(name: 'intro_video_url')
    String? videoUrl, // Explicitly map if DB is different
    String? avatarUrl,

    // Children lists (handled automatically if DB returns nested arrays)
    @Default([]) List<WorkExperience> workExperiences,
    @Default([]) List<Education> educations,
    @Default([]) List<Certification> certifications,
    
    @Default([]) List<String> skills,
    @Default([]) List<String> languages,

    // THE MAGIC FIX:
    // 1. readValue: _readRoot passes the entire DB response to JobPreferencesEntity
    // 2. JobPreferencesEntity extracts 'min_salary', etc. from that root map
    @JsonKey(readValue: _readRoot)
    @Default(JobPreferencesEntity())
    JobPreferencesEntity jobPreferences,
    
  }) = _UserEntity;

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);
}
