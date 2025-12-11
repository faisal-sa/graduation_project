import 'dart:io';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduation_project/features/individuals/features/certifications/domain/entities/certification.dart';

part 'certification_model.freezed.dart';
part 'certification_model.g.dart';

@freezed
abstract class CertificationModel with _$CertificationModel {
  const CertificationModel._();

  const factory CertificationModel({
    required String id,
    required String name,
    @JsonKey(name: 'issuing_institution') required String issuingInstitution,
    @JsonKey(name: 'issue_date') required DateTime issueDate,
    @JsonKey(name: 'expiration_date') DateTime? expirationDate,
    @JsonKey(name: 'credential_url') String? credentialUrl,

    // File/Local fields ignored in JSON
    @JsonKey(includeFromJson: false, includeToJson: false) File? credentialFile,
    
    // In your provided snippet, userId was a field in the model.
    // If you want it part of the constructor but not the Entity interface:
    @JsonKey(name: 'user_id') required String userId,
  }) = _CertificationModel;

  factory CertificationModel.fromJson(Map<String, dynamic> json) =>
      _$CertificationModelFromJson(json);

  factory CertificationModel.fromEntity(
    Certification certification,
    String userId, {
    String? uploadedUrl,
  }) {
    return CertificationModel(
      id: certification.id,
      userId: userId,
      name: certification.name,
      issuingInstitution: certification.issuingInstitution,
      issueDate: certification.issueDate,
      expirationDate: certification.expirationDate,
      credentialUrl: uploadedUrl ?? certification.credentialUrl,
      credentialFile:
          null, // Models usually don't hold the local file after conversion
    );
  }
  Certification toEntity() {
    return Certification(
      id: id,
      name: name,
      issuingInstitution: issuingInstitution,
      issueDate: issueDate,
      expirationDate: expirationDate,
      credentialUrl: credentialUrl,
      
      // --- UNCOMMENT THIS ---
      credentialFile: credentialFile,
      // ----------------------
    );
  }
}

