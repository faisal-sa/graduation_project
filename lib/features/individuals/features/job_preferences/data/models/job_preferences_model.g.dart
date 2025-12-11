// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_preferences_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JobPreferencesModel _$JobPreferencesModelFromJson(Map<String, dynamic> json) =>
    _JobPreferencesModel(
      targetRoles:
          (json['target_roles'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      minSalary: json['min_salary'] as num?,
      maxSalary: json['max_salary'] as num?,
      salaryCurrency: json['salary_currency'] as String?,
      currentWorkStatus: json['current_work_status'] as String?,
      employmentTypes:
          (json['employment_types'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      workModes:
          (json['work_modes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      canRelocate: json['can_relocate'] as bool? ?? false,
      canStartImmediately: json['can_start_immediately'] as bool? ?? false,
      noticePeriodDays: (json['notice_period_days'] as num?)?.toInt(),
    );

Map<String, dynamic> _$JobPreferencesModelToJson(
  _JobPreferencesModel instance,
) => <String, dynamic>{
  'target_roles': instance.targetRoles,
  'min_salary': instance.minSalary,
  'max_salary': instance.maxSalary,
  'salary_currency': instance.salaryCurrency,
  'current_work_status': instance.currentWorkStatus,
  'employment_types': instance.employmentTypes,
  'work_modes': instance.workModes,
  'can_relocate': instance.canRelocate,
  'can_start_immediately': instance.canStartImmediately,
  'notice_period_days': instance.noticePeriodDays,
};
