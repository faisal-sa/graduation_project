import 'dart:io';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'certification.freezed.dart';
part 'certification.g.dart';
@freezed
abstract class Certification with _$Certification {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Certification({
    required String id,
    @Default('') String name,
    @Default('') String issuingInstitution,
    required DateTime issueDate,
    DateTime? expirationDate,
    String? credentialUrl,
    
    // --- ADD THIS FIELD ---
    // We ignore this for JSON because a File object cannot be serialized directly.
    @JsonKey(includeFromJson: false, includeToJson: false) File? credentialFile,

    // ----------------------

  }) = _Certification;

  factory Certification.fromJson(Map<String, dynamic> json) =>
      _$CertificationFromJson(json);
}
