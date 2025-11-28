import '../../domain/entities/education.dart';

class EducationModel extends Education {
  const EducationModel({
    required super.id,
    required super.degreeType,
    required super.institutionName,
    required super.fieldOfStudy,
    required super.startDate,
    required super.endDate,
    super.gpa,
    super.activities,
    super.graduationCertificateUrl,
    super.academicRecordUrl,
  });

  factory EducationModel.fromJson(Map<String, dynamic> json) {
    return EducationModel(
      id: json['id'] as String,
      degreeType: json['degree_type'] ?? '',
      institutionName: json['institution_name'] ?? '',
      fieldOfStudy: json['field_of_study'] ?? '',
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      gpa: json['gpa'] as String?,
      activities:
          (json['activities'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      graduationCertificateUrl: json['graduation_certificate_url'] as String?,
      academicRecordUrl: json['academic_record_url'] as String?,
    );
  }

  Map<String, dynamic> toJson({required String userId}) {
    return {
      'user_id': userId,
      'degree_type': degreeType,
      'institution_name': institutionName,
      'field_of_study': fieldOfStudy,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'gpa': gpa,
      'activities': activities,
      'graduation_certificate_url': graduationCertificateUrl,
      'academic_record_url': academicRecordUrl,
    };
  }
}
