import 'dart:convert';
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'degreeType': degreeType,
      'institutionName': institutionName,
      'fieldOfStudy': fieldOfStudy,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'gpa': gpa,
      'activities': activities,
      'graduationCertificateBytes': graduationCertificateBytes != null
          ? base64Encode(graduationCertificateBytes!)
          : null,
      'graduationCertificateName': graduationCertificateName,
      'academicRecordBytes': academicRecordBytes != null
          ? base64Encode(academicRecordBytes!)
          : null,
      'academicRecordName': academicRecordName,
      'graduationCertificateUrl': graduationCertificateUrl,
      'academicRecordUrl': academicRecordUrl,
    };
  }

  factory Education.fromMap(Map<String, dynamic> map) {
    return Education(
      id: map['id'] ?? '',
      degreeType: map['degreeType'] ?? '',
      institutionName: map['institutionName'] ?? '',
      fieldOfStudy: map['fieldOfStudy'] ?? '',
      startDate: DateTime.parse(map['startDate']),
      endDate: DateTime.parse(map['endDate']),
      gpa: map['gpa'],
      activities: List<String>.from(map['activities'] ?? []),
      graduationCertificateBytes: map['graduationCertificateBytes'] != null
          ? base64Decode(map['graduationCertificateBytes'])
          : null,
      graduationCertificateName: map['graduationCertificateName'],
      academicRecordBytes: map['academicRecordBytes'] != null
          ? base64Decode(map['academicRecordBytes'])
          : null,
      academicRecordName: map['academicRecordName'],
      graduationCertificateUrl: map['graduationCertificateUrl'],
      academicRecordUrl: map['academicRecordUrl'],
    );
  }

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
