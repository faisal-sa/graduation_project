// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Certification _$CertificationFromJson(Map<String, dynamic> json) =>
    _Certification(
      id: json['id'] as String,
      name: json['name'] as String? ?? '',
      issuingInstitution: json['issuingInstitution'] as String? ?? '',
      issueDate: DateTime.parse(json['issueDate'] as String),
      expirationDate: json['expirationDate'] == null
          ? null
          : DateTime.parse(json['expirationDate'] as String),
      credentialUrl: json['credentialUrl'] as String?,
    );

Map<String, dynamic> _$CertificationToJson(_Certification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'issuingInstitution': instance.issuingInstitution,
      'issueDate': instance.issueDate.toIso8601String(),
      'expirationDate': instance.expirationDate?.toIso8601String(),
      'credentialUrl': instance.credentialUrl,
    };
