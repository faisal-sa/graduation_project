import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_preferences_entity.freezed.dart';
part 'job_preferences_entity.g.dart';

@freezed
abstract class JobPreferencesEntity with _$JobPreferencesEntity {
  // Ensure snake_case so it finds 'min_salary' in the root map
  @JsonSerializable(fieldRename: FieldRename.snake) 
  const factory JobPreferencesEntity({
    @Default([]) List<String> targetRoles,
    int? minSalary,
    int? maxSalary,
    @Default('SAR') String? salaryCurrency,
    String? currentWorkStatus,
    @Default([]) List<String> employmentTypes,
    @Default([]) List<String> workModes,
    @Default(false) bool canRelocate,
    @Default(false) bool canStartImmediately,
    int? noticePeriodDays,
  }) = _JobPreferencesEntity;

  factory JobPreferencesEntity.fromJson(Map<String, dynamic> json) =>
      _$JobPreferencesEntityFromJson(json);
}
