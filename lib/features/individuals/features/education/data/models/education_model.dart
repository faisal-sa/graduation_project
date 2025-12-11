import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/education.dart';


part 'education_model.freezed.dart';
part 'education_model.g.dart';

@freezed
abstract class EducationModel with _$EducationModel {
  const EducationModel._();

  const factory EducationModel({
    required String id,
    @JsonKey(name: 'degree_type') required String degreeType,
    @JsonKey(name: 'institution_name') required String institutionName,
    @JsonKey(name: 'field_of_study') required String fieldOfStudy,
    @JsonKey(name: 'start_date') required DateTime startDate,
    @JsonKey(name: 'end_date') required DateTime endDate,
    String? gpa,
    @Default([]) List<String> activities,
    @JsonKey(name: 'graduation_certificate_url')
    String? graduationCertificateUrl,
    @JsonKey(name: 'academic_record_url') String? academicRecordUrl,

    // Fields that are not part of the JSON payload
    @JsonKey(includeFromJson: false, includeToJson: false)
    dynamic graduationCertificateBytes,
    @JsonKey(includeFromJson: false, includeToJson: false)
    String? graduationCertificateName,
    @JsonKey(includeFromJson: false, includeToJson: false)
    dynamic academicRecordBytes,
    @JsonKey(includeFromJson: false, includeToJson: false)
    String? academicRecordName,
  }) = _EducationModel;

  factory EducationModel.fromJson(Map<String, dynamic> json) =>
      _$EducationModelFromJson(json);

  factory EducationModel.fromEntity(Education entity) {
    return EducationModel(
      id: entity.id,
      degreeType: entity.degreeType,
      institutionName: entity.institutionName,
      fieldOfStudy: entity.fieldOfStudy,
      startDate: entity.startDate,
      endDate: entity.endDate,
      gpa: entity.gpa,
      activities: entity.activities ?? [],
      graduationCertificateUrl: entity.graduationCertificateUrl,
      academicRecordUrl: entity.academicRecordUrl,
      // Map local fields if they exist in entity
      graduationCertificateBytes: entity.graduationCertificateBytes,
      graduationCertificateName: entity.graduationCertificateName,
      academicRecordBytes: entity.academicRecordBytes,
      academicRecordName: entity.academicRecordName,
    );
  }
  Education toEntity() {
    return Education(
      id: id,
      degreeType: degreeType,
      institutionName: institutionName,
      fieldOfStudy: fieldOfStudy,
      startDate: startDate,
      endDate: endDate,
      gpa: gpa,
      activities: activities,
      graduationCertificateUrl: graduationCertificateUrl,
      academicRecordUrl: academicRecordUrl,
      // Cast the dynamic fields to the specific type required by the entity
      graduationCertificateBytes: graduationCertificateBytes as Uint8List?,
      graduationCertificateName: graduationCertificateName,
      academicRecordBytes: academicRecordBytes as Uint8List?,
      academicRecordName: academicRecordName,
    );
  }

  Map<String, dynamic> toApiJson({required String userId}) {
    final json = toJson();
    json['user_id'] = userId;
    return json;
  }
}
