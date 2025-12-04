import 'package:graduation_project/features/individuals/features/job_preferences/domain/entities/job_preferences_entity.dart';

class JobPreferencesModel extends JobPreferencesEntity {
  const JobPreferencesModel({
    super.targetRoles,
    super.minSalary,
    super.maxSalary,
    super.salaryCurrency,
    super.currentWorkStatus,
    super.employmentTypes,
    super.workModes,
    super.canRelocate,
    super.canStartImmediately,
    super.noticePeriodDays,
  });

  factory JobPreferencesModel.fromJson(Map<String, dynamic> json) {
    return JobPreferencesModel(
      targetRoles: List<String>.from(json['target_roles'] ?? []),
      minSalary: json['min_salary'],
      maxSalary: json['max_salary'],
      salaryCurrency: json['salary_currency'],
      currentWorkStatus: json['current_work_status'],
      employmentTypes: List<String>.from(json['employment_types'] ?? []),
      workModes: List<String>.from(json['work_modes'] ?? []),
      canRelocate: json['can_relocate'] ?? false,
      canStartImmediately: json['can_start_immediately'] ?? false,
      noticePeriodDays: json['notice_period_days'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'target_roles': targetRoles,
      'min_salary': minSalary,
      'max_salary': maxSalary,
      'salary_currency': salaryCurrency,
      'current_work_status': currentWorkStatus,
      'employment_types': employmentTypes,
      'work_modes': workModes,
      'can_relocate': canRelocate,
      'can_start_immediately': canStartImmediately,
      'notice_period_days': noticePeriodDays,
      'updated_at': DateTime.now().toIso8601String(),
    };
  }

  factory JobPreferencesModel.fromEntity(JobPreferencesEntity entity) {
    return JobPreferencesModel(
      targetRoles: entity.targetRoles,
      minSalary: entity.minSalary,
      maxSalary: entity.maxSalary,
      salaryCurrency: entity.salaryCurrency,
      currentWorkStatus: entity.currentWorkStatus,
      employmentTypes: entity.employmentTypes,
      workModes: entity.workModes,
      canRelocate: entity.canRelocate,
      canStartImmediately: entity.canStartImmediately,
      noticePeriodDays: entity.noticePeriodDays,
    );
  }
}
