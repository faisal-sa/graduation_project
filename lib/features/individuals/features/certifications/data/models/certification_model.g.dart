// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CertificationModel _$CertificationModelFromJson(Map<String, dynamic> json) =>
    CertificationModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      name: json['name'] as String,
      issuingInstitutionModel: json['issuing_institution'] as String,
      issueDateModel: DateTime.parse(json['issue_date'] as String),
      expirationDateModel: json['expiration_date'] == null
          ? null
          : DateTime.parse(json['expiration_date'] as String),
      credentialUrlModel: json['credential_url'] as String?,
    );

Map<String, dynamic> _$CertificationModelToJson(CertificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'user_id': instance.userId,
      'credential_url': instance.credentialUrlModel,
      'issue_date': instance.issueDateModel.toIso8601String(),
      'expiration_date': instance.expirationDateModel?.toIso8601String(),
      'issuing_institution': instance.issuingInstitutionModel,
    };
