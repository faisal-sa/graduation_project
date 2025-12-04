import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduation_project/features/individuals/features/certifications/domain/entities/certification.dart';

part 'certification_model.g.dart';

@JsonSerializable()
class CertificationModel extends Certification {
  @JsonKey(name: 'user_id')
  final String userId;

  @JsonKey(name: 'credential_url')
  final String? credentialUrlModel;

  @JsonKey(name: 'issue_date')
  final DateTime issueDateModel;

  @JsonKey(name: 'expiration_date')
  final DateTime? expirationDateModel;

  @JsonKey(name: 'issuing_institution')
  final String issuingInstitutionModel;

  const CertificationModel({
    required super.id,
    required this.userId,
    required super.name,
    required this.issuingInstitutionModel,
    required this.issueDateModel,
    this.expirationDateModel,
    this.credentialUrlModel,
  }) : super(
         issuingInstitution: issuingInstitutionModel,
         issueDate: issueDateModel,
         expirationDate: expirationDateModel,
         credentialUrl: credentialUrlModel,
         // credentialFile is local-only, not mapped from DB JSON
         credentialFile: null,
       );

  factory CertificationModel.fromJson(Map<String, dynamic> json) =>
      _$CertificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$CertificationModelToJson(this);

  // Helper to convert Entity -> Model for DB operations
  factory CertificationModel.fromEntity(
    Certification certification,
    String userId, {
    String? uploadedUrl,
  }) {
    return CertificationModel(
      id: certification.id,
      userId: userId,
      name: certification.name,
      issuingInstitutionModel: certification.issuingInstitution,
      issueDateModel: certification.issueDate,
      expirationDateModel: certification.expirationDate,
      credentialUrlModel: uploadedUrl ?? certification.credentialUrl,
    );
  }
}
