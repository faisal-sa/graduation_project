import 'dart:typed_data';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduation_project/core/utils/json_converters.dart';

part 'education.freezed.dart';
part 'education.g.dart';
@freezed
abstract class Education with _$Education {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Education({
    required String id,
    @Default('') String degreeType,
    @Default('') String institutionName,
    @Default('') String fieldOfStudy,
    required DateTime startDate,
    required DateTime endDate,
    String? gpa,
    @Default([]) List<String> activities,
    String? graduationCertificateUrl,
    String? academicRecordUrl,
    
    // --- ADD THESE MISSING FIELDS ---
    @JsonKey(includeFromJson: false) String? graduationCertificateName,
    @JsonKey(includeFromJson: false) String? academicRecordName,

    // Existing byte fields
    @JsonKey(includeFromJson: false) Uint8List? graduationCertificateBytes,
    @JsonKey(includeFromJson: false) Uint8List? academicRecordBytes,
  }) = _Education;

  factory Education.fromJson(Map<String, dynamic> json) =>
      _$EducationFromJson(json);
}
