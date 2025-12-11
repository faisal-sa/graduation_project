// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Certification _$CertificationFromJson(Map<String, dynamic> json) =>
    _Certification(
      id: json['id'] as String,
      name: json['name'] as String? ?? '',
      issuingInstitution: json['issuing_institution'] as String? ?? '',
      issueDate: DateTime.parse(json['issue_date'] as String),
      expirationDate: json['expiration_date'] == null
          ? null
          : DateTime.parse(json['expiration_date'] as String),
      credentialUrl: json['credential_url'] as String?,
    );

Map<String, dynamic> _$CertificationToJson(_Certification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'issuing_institution': instance.issuingInstitution,
      'issue_date': instance.issueDate.toIso8601String(),
      'expiration_date': instance.expirationDate?.toIso8601String(),
      'credential_url': instance.credentialUrl,
    };
