import 'package:equatable/equatable.dart';

class JobPreferencesEntity extends Equatable {
  final List<String> targetRoles;
  final int? minSalary;
  final int? maxSalary;
  final String? salaryCurrency;
  final String? currentWorkStatus;
  final List<String> employmentTypes;
  final List<String> workModes;
  final bool canRelocate;
  final bool canStartImmediately;
  final int? noticePeriodDays;

  const JobPreferencesEntity({
    this.targetRoles = const [],
    this.minSalary,
    this.maxSalary,
    this.salaryCurrency = 'SAR', // Set default
    this.currentWorkStatus,
    this.employmentTypes = const [],
    this.workModes = const [],
    this.canRelocate = false,
    this.canStartImmediately = false,
    this.noticePeriodDays,
  });

  // ... (keep copyWith if you have it) ...

  @override
  List<Object?> get props => [
    targetRoles,
    minSalary,
    maxSalary,
    salaryCurrency,
    currentWorkStatus,
    employmentTypes,
    workModes,
    canRelocate,
    canStartImmediately,
    noticePeriodDays,
  ];

  // --- NEW: Serialization Logic ---

  Map<String, dynamic> toMap() {
    return {
      'targetRoles': targetRoles,
      'minSalary': minSalary,
      'maxSalary': maxSalary,
      'salaryCurrency': salaryCurrency,
      'currentWorkStatus': currentWorkStatus,
      'employmentTypes': employmentTypes,
      'workModes': workModes,
      'canRelocate': canRelocate,
      'canStartImmediately': canStartImmediately,
      'noticePeriodDays': noticePeriodDays,
    };
  }

  factory JobPreferencesEntity.fromMap(Map<String, dynamic> map) {
    return JobPreferencesEntity(
      targetRoles: List<String>.from(map['targetRoles'] ?? []),
      minSalary: map['minSalary'],
      maxSalary: map['maxSalary'],
      salaryCurrency: map['salaryCurrency'],
      currentWorkStatus: map['currentWorkStatus'],
      employmentTypes: List<String>.from(map['employmentTypes'] ?? []),
      workModes: List<String>.from(map['workModes'] ?? []),
      canRelocate: map['canRelocate'] ?? false,
      canStartImmediately: map['canStartImmediately'] ?? false,
      noticePeriodDays: map['noticePeriodDays'],
    );
  }
}


// class JobPreferencesEntity {
//   final List<String> targetRoles;
//   final int? minSalary;
//   final int? maxSalary;
//   final String? salaryCurrency;
//   final String? currentWorkStatus;
//   final List<String> employmentTypes;
//   final List<String> workModes;
//   final bool canRelocate;
//   final bool canStartImmediately;
//   final int? noticePeriodDays; // Can be string depending on your DB, keeping int based on context

//   JobPreferencesEntity({
//     this.targetRoles = const [],
//     this.minSalary,
//     this.maxSalary,
//     this.salaryCurrency,
//     this.currentWorkStatus,
//     this.employmentTypes = const [],
//     this.workModes = const [],
//     this.canRelocate = false,
//     this.canStartImmediately = false,
//     this.noticePeriodDays,
//   });
// }