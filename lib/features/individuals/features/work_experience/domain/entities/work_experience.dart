import 'package:equatable/equatable.dart';

class WorkExperience extends Equatable {
  final String id;
  final String jobTitle;
  final String companyName;
  final String employmentType;
  final String location;
  final List<String> responsibilities;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isCurrentlyWorking;

  const WorkExperience({
    required this.id,
    required this.jobTitle,
    required this.companyName,
    required this.employmentType,
    required this.location,
    required this.responsibilities,
    required this.startDate,
    this.endDate,
    this.isCurrentlyWorking = false,
  });

  @override
  List<Object?> get props => [
    id,
    jobTitle,
    companyName,
    startDate,
    endDate,
    responsibilities,
  ];
}
