import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduation_project/features/individuals/profile/routes/job_preferences/domain/entities/job_preferences_entity.dart';



part 'job_preferences_model.freezed.dart';
part 'job_preferences_model.g.dart';

@freezed
abstract class JobPreferencesModel with _$JobPreferencesModel {
  const JobPreferencesModel._();

  const factory JobPreferencesModel({
    @JsonKey(name: 'target_roles') @Default([]) List<String> targetRoles,
    @JsonKey(name: 'min_salary')
    num? minSalary,
    @JsonKey(name: 'max_salary') num? maxSalary,
    @JsonKey(name: 'salary_currency') String? salaryCurrency,
    @JsonKey(name: 'current_work_status') String? currentWorkStatus,
    @JsonKey(name: 'employment_types')
    @Default([])
    List<String> employmentTypes,
    @JsonKey(name: 'work_modes') @Default([]) List<String> workModes,
    @JsonKey(name: 'can_relocate') @Default(false) bool canRelocate,
    @JsonKey(name: 'can_start_immediately')
    @Default(false)
    bool canStartImmediately,
    @JsonKey(name: 'notice_period_days') int? noticePeriodDays,
  }) = _JobPreferencesModel;

  factory JobPreferencesModel.fromJson(Map<String, dynamic> json) =>
      _$JobPreferencesModelFromJson(json);

  factory JobPreferencesModel.fromEntity(JobPreferencesEntity entity) {
    return JobPreferencesModel(
      targetRoles: entity.targetRoles ,
      minSalary: entity.minSalary,
      maxSalary: entity.maxSalary,
      salaryCurrency: entity.salaryCurrency,
      currentWorkStatus: entity.currentWorkStatus,
      employmentTypes: entity.employmentTypes ,
      workModes: entity.workModes ,
      canRelocate: entity.canRelocate ,
      canStartImmediately: entity.canStartImmediately ,
      noticePeriodDays: entity.noticePeriodDays,
    );
  }
JobPreferencesEntity toEntity() {
    return JobPreferencesEntity(
      targetRoles: targetRoles,
      minSalary: minSalary?.toInt(), 
      maxSalary: maxSalary?.toInt(),
      salaryCurrency: salaryCurrency,
      currentWorkStatus: currentWorkStatus,
      employmentTypes: employmentTypes,
      workModes: workModes,
      canRelocate: canRelocate,
      canStartImmediately: canStartImmediately,
      noticePeriodDays: noticePeriodDays,
    );
  }

  Map<String, dynamic> toApiJson() {
    final json = toJson();
    json['updated_at'] = DateTime.now().toIso8601String();
    return json;
  }
}
