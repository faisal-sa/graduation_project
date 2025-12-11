// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CertificationModel _$CertificationModelFromJson(Map<String, dynamic> json) =>
    _CertificationModel(
      id: json['id'] as String,
      name: json['name'] as String,
      issuingInstitution: json['issuing_institution'] as String,
      issueDate: DateTime.parse(json['issue_date'] as String),
      expirationDate: json['expiration_date'] == null
          ? null
          : DateTime.parse(json['expiration_date'] as String),
      credentialUrl: json['credential_url'] as String?,
      userId: json['user_id'] as String,
    );

Map<String, dynamic> _$CertificationModelToJson(_CertificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'issuing_institution': instance.issuingInstitution,
      'issue_date': instance.issueDate.toIso8601String(),
      'expiration_date': instance.expirationDate?.toIso8601String(),
      'credential_url': instance.credentialUrl,
      'user_id': instance.userId,
    };
