// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'certification_model.dart';

class CertificationModelMapper extends ClassMapperBase<CertificationModel> {
  CertificationModelMapper._();

  static CertificationModelMapper? _instance;
  static CertificationModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CertificationModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'CertificationModel';

  static String _$id(CertificationModel v) => v.id;
  static const Field<CertificationModel, String> _f$id = Field('id', _$id);
  static String _$name(CertificationModel v) => v.name;
  static const Field<CertificationModel, String> _f$name = Field(
    'name',
    _$name,
  );
  static String _$issuingInstitution(CertificationModel v) =>
      v.issuingInstitution;
  static const Field<CertificationModel, String> _f$issuingInstitution = Field(
    'issuingInstitution',
    _$issuingInstitution,
    key: r'issuing_institution',
  );
  static DateTime _$issueDate(CertificationModel v) => v.issueDate;
  static const Field<CertificationModel, DateTime> _f$issueDate = Field(
    'issueDate',
    _$issueDate,
    key: r'issue_date',
  );
  static DateTime? _$expirationDate(CertificationModel v) => v.expirationDate;
  static const Field<CertificationModel, DateTime> _f$expirationDate = Field(
    'expirationDate',
    _$expirationDate,
    key: r'expiration_date',
    opt: true,
  );
  static String? _$credentialUrl(CertificationModel v) => v.credentialUrl;
  static const Field<CertificationModel, String> _f$credentialUrl = Field(
    'credentialUrl',
    _$credentialUrl,
    key: r'credential_url',
    opt: true,
  );

  @override
  final MappableFields<CertificationModel> fields = const {
    #id: _f$id,
    #name: _f$name,
    #issuingInstitution: _f$issuingInstitution,
    #issueDate: _f$issueDate,
    #expirationDate: _f$expirationDate,
    #credentialUrl: _f$credentialUrl,
  };

  static CertificationModel _instantiate(DecodingData data) {
    return CertificationModel(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      issuingInstitution: data.dec(_f$issuingInstitution),
      issueDate: data.dec(_f$issueDate),
      expirationDate: data.dec(_f$expirationDate),
      credentialUrl: data.dec(_f$credentialUrl),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CertificationModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CertificationModel>(map);
  }

  static CertificationModel fromJson(String json) {
    return ensureInitialized().decodeJson<CertificationModel>(json);
  }
}

mixin CertificationModelMappable {
  String toJson() {
    return CertificationModelMapper.ensureInitialized()
        .encodeJson<CertificationModel>(this as CertificationModel);
  }

  Map<String, dynamic> toMap() {
    return CertificationModelMapper.ensureInitialized()
        .encodeMap<CertificationModel>(this as CertificationModel);
  }

  CertificationModelCopyWith<
    CertificationModel,
    CertificationModel,
    CertificationModel
  >
  get copyWith =>
      _CertificationModelCopyWithImpl<CertificationModel, CertificationModel>(
        this as CertificationModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return CertificationModelMapper.ensureInitialized().stringifyValue(
      this as CertificationModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return CertificationModelMapper.ensureInitialized().equalsValue(
      this as CertificationModel,
      other,
    );
  }

  @override
  int get hashCode {
    return CertificationModelMapper.ensureInitialized().hashValue(
      this as CertificationModel,
    );
  }
}

extension CertificationModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CertificationModel, $Out> {
  CertificationModelCopyWith<$R, CertificationModel, $Out>
  get $asCertificationModel => $base.as(
    (v, t, t2) => _CertificationModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class CertificationModelCopyWith<
  $R,
  $In extends CertificationModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? name,
    String? issuingInstitution,
    DateTime? issueDate,
    DateTime? expirationDate,
    String? credentialUrl,
  });
  CertificationModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _CertificationModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CertificationModel, $Out>
    implements CertificationModelCopyWith<$R, CertificationModel, $Out> {
  _CertificationModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CertificationModel> $mapper =
      CertificationModelMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? name,
    String? issuingInstitution,
    DateTime? issueDate,
    Object? expirationDate = $none,
    Object? credentialUrl = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (issuingInstitution != null) #issuingInstitution: issuingInstitution,
      if (issueDate != null) #issueDate: issueDate,
      if (expirationDate != $none) #expirationDate: expirationDate,
      if (credentialUrl != $none) #credentialUrl: credentialUrl,
    }),
  );
  @override
  CertificationModel $make(CopyWithData data) => CertificationModel(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    issuingInstitution: data.get(
      #issuingInstitution,
      or: $value.issuingInstitution,
    ),
    issueDate: data.get(#issueDate, or: $value.issueDate),
    expirationDate: data.get(#expirationDate, or: $value.expirationDate),
    credentialUrl: data.get(#credentialUrl, or: $value.credentialUrl),
  );

  @override
  CertificationModelCopyWith<$R2, CertificationModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CertificationModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

