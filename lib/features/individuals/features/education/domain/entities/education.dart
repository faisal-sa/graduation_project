import 'dart:typed_data';

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

  final Uint8List? graduationCertificateBytes;
  final String? graduationCertificateName;

  final Uint8List? academicRecordBytes;
  final String? academicRecordName;

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

    this.graduationCertificateBytes,
    this.graduationCertificateName,

    this.academicRecordBytes,
    this.academicRecordName,

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
    graduationCertificateBytes,
    graduationCertificateName,
    academicRecordBytes,
    academicRecordName,
    graduationCertificateUrl,
    academicRecordUrl,
  ];
}
