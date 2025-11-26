import 'package:equatable/equatable.dart';

enum FormStatus { initial, loading, success, failure }

class WorkExperienceFormState extends Equatable {
  final String jobTitle;
  final String companyName;
  final String location;
  final String employmentType;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isCurrentlyWorking;
  final List<String> responsibilities;
  final FormStatus status;
  final String? errorMessage;

  const WorkExperienceFormState({
    this.jobTitle = '',
    this.companyName = '',
    this.location = '',
    this.employmentType = 'Full-time',
    this.startDate,
    this.endDate,
    this.isCurrentlyWorking = false,
    this.responsibilities = const [],
    this.status = FormStatus.initial,
    this.errorMessage,
  });

  WorkExperienceFormState copyWith({
    String? jobTitle,
    String? companyName,
    String? location,
    String? employmentType,
    DateTime? startDate,
    DateTime? endDate,
    bool? isCurrentlyWorking,
    List<String>? responsibilities,
    FormStatus? status,
    String? errorMessage,
  }) {
    return WorkExperienceFormState(
      jobTitle: jobTitle ?? this.jobTitle,
      companyName: companyName ?? this.companyName,
      location: location ?? this.location,
      employmentType: employmentType ?? this.employmentType,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isCurrentlyWorking: isCurrentlyWorking ?? this.isCurrentlyWorking,
      responsibilities: responsibilities ?? this.responsibilities,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    jobTitle,
    companyName,
    location,
    employmentType,
    startDate,
    endDate,
    isCurrentlyWorking,
    responsibilities,
    status,
    errorMessage,
  ];
}
