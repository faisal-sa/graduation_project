import 'dart:io';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'certification.freezed.dart';
part 'certification.g.dart';

@freezed
abstract class Certification with _$Certification {
  const factory Certification({
    required String id,
    @Default('') String name,
    @Default('') String issuingInstitution,
    required DateTime issueDate,
    DateTime? expirationDate,
    
    // Ignored in JSON, just like your original code
    @JsonKey(includeFromJson: false, includeToJson: false) File? credentialFile,
    
    String? credentialUrl,
  }) = _Certification;

  factory Certification.fromJson(Map<String, dynamic> json) =>
      _$CertificationFromJson(json);
}
