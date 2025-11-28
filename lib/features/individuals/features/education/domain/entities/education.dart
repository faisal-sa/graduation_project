import 'dart:io';

import 'package:equatable/equatable.dart';


class Education extends Equatable {
  final String id;
  final String degreeType;
  final String institutionName;
  final String fieldOfStudy;
  final DateTime startDate;
  final DateTime endDate;
  final String? gpa;
  final List<String> activities;

  // Files selected from device (for upload)
  final File? graduationCertificate;
  final File? academicRecord;

  // URLs returned from server (for display)
  final String? graduationCertificateUrl;
  final String? academicRecordUrl;

  const Education({
    required this.id,
    required this.degreeType,
    required this.institutionName,
    required this.fieldOfStudy,
    required this.startDate,
    required this.endDate,
    this.gpa,
    this.activities = const [],
    this.graduationCertificate,
    this.academicRecord,
    this.graduationCertificateUrl,
    this.academicRecordUrl,
  });

  @override
  List<Object?> get props => [
    id,
    degreeType,
    institutionName,
    fieldOfStudy,
    startDate,
    endDate,
    gpa,
    activities,
    graduationCertificate,
    academicRecord,
    graduationCertificateUrl,
    academicRecordUrl,
  ];
}
