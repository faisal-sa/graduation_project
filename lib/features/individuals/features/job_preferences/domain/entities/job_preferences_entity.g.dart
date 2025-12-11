// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_preferences_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JobPreferencesEntity _$JobPreferencesEntityFromJson(
  Map<String, dynamic> json,
) => _JobPreferencesEntity(
  targetRoles:
      (json['targetRoles'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  minSalary: (json['minSalary'] as num?)?.toInt(),
  maxSalary: (json['maxSalary'] as num?)?.toInt(),
  salaryCurrency: json['salaryCurrency'] as String? ?? 'SAR',
  currentWorkStatus: json['currentWorkStatus'] as String?,
  employmentTypes:
      (json['employmentTypes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  workModes:
      (json['workModes'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  canRelocate: json['canRelocate'] as bool? ?? false,
  canStartImmediately: json['canStartImmediately'] as bool? ?? false,
  noticePeriodDays: (json['noticePeriodDays'] as num?)?.toInt(),
);

Map<String, dynamic> _$JobPreferencesEntityToJson(
  _JobPreferencesEntity instance,
) => <String, dynamic>{
  'targetRoles': instance.targetRoles,
  'minSalary': instance.minSalary,
  'maxSalary': instance.maxSalary,
  'salaryCurrency': instance.salaryCurrency,
  'currentWorkStatus': instance.currentWorkStatus,
  'employmentTypes': instance.employmentTypes,
  'workModes': instance.workModes,
  'canRelocate': instance.canRelocate,
  'canStartImmediately': instance.canStartImmediately,
  'noticePeriodDays': instance.noticePeriodDays,
};
