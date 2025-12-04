import 'dart:convert';

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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'jobTitle': jobTitle,
      'companyName': companyName,
      'employmentType': employmentType,
      'location': location,
      'responsibilities': responsibilities,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'isCurrentlyWorking': isCurrentlyWorking,
    };
  }

  factory WorkExperience.fromMap(Map<String, dynamic> map) {
    return WorkExperience(
      id: map['id'] ?? '',
      jobTitle: map['jobTitle'] ?? '',
      companyName: map['companyName'] ?? '',
      employmentType: map['employmentType'] ?? '',
      location: map['location'] ?? '',
      responsibilities: List<String>.from(map['responsibilities'] ?? []),
      startDate: DateTime.parse(map['startDate']),
      endDate: map['endDate'] != null ? DateTime.parse(map['endDate']) : null,
      isCurrentlyWorking: map['isCurrentlyWorking'] ?? false,
    );
  }


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
