

import 'package:freezed_annotation/freezed_annotation.dart';

part 'work_experience.freezed.dart';
part 'work_experience.g.dart';

@freezed
abstract class WorkExperience with _$WorkExperience {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory WorkExperience({
    required String id,
    @Default('') String jobTitle,
    @Default('') String companyName,
    @Default('') String employmentType,
    @Default('') String location,
    @Default([]) List<String> responsibilities,
    required DateTime startDate,
    DateTime? endDate,
    @Default(false) bool isCurrentlyWorking,
  }) = _WorkExperience;

  factory WorkExperience.fromJson(Map<String, dynamic> json) =>
      _$WorkExperienceFromJson(json);
}
