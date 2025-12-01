// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'company_model.dart';

class CompanyModelMapper extends ClassMapperBase<CompanyModel> {
  CompanyModelMapper._();

  static CompanyModelMapper? _instance;
  static CompanyModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CompanyModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'CompanyModel';

  static String _$id(CompanyModel v) => v.id;
  static const Field<CompanyModel, String> _f$id = Field('id', _$id);
  static String _$userId(CompanyModel v) => v.userId;
  static const Field<CompanyModel, String> _f$userId = Field(
    'userId',
    _$userId,
    key: r'user_id',
  );
  static String _$companyName(CompanyModel v) => v.companyName;
  static const Field<CompanyModel, String> _f$companyName = Field(
    'companyName',
    _$companyName,
    key: r'company_name',
  );
  static String _$industry(CompanyModel v) => v.industry;
  static const Field<CompanyModel, String> _f$industry = Field(
    'industry',
    _$industry,
  );
  static String _$description(CompanyModel v) => v.description;
  static const Field<CompanyModel, String> _f$description = Field(
    'description',
    _$description,
  );
  static String _$city(CompanyModel v) => v.city;
  static const Field<CompanyModel, String> _f$city = Field('city', _$city);
  static String? _$address(CompanyModel v) => v.address;
  static const Field<CompanyModel, String> _f$address = Field(
    'address',
    _$address,
    opt: true,
  );
  static String? _$companySize(CompanyModel v) => v.companySize;
  static const Field<CompanyModel, String> _f$companySize = Field(
    'companySize',
    _$companySize,
    key: r'company_size',
    opt: true,
  );
  static String? _$website(CompanyModel v) => v.website;
  static const Field<CompanyModel, String> _f$website = Field(
    'website',
    _$website,
    opt: true,
  );
  static String? _$email(CompanyModel v) => v.email;
  static const Field<CompanyModel, String> _f$email = Field(
    'email',
    _$email,
    opt: true,
  );
  static String? _$phone(CompanyModel v) => v.phone;
  static const Field<CompanyModel, String> _f$phone = Field(
    'phone',
    _$phone,
    opt: true,
  );
  static String? _$logoUrl(CompanyModel v) => v.logoUrl;
  static const Field<CompanyModel, String> _f$logoUrl = Field(
    'logoUrl',
    _$logoUrl,
    key: r'logo_url',
    opt: true,
  );
  static String _$createdAt(CompanyModel v) => v.createdAt;
  static const Field<CompanyModel, String> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    key: r'created_at',
  );
  static String _$updatedAt(CompanyModel v) => v.updatedAt;
  static const Field<CompanyModel, String> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
    key: r'updated_at',
  );

  @override
  final MappableFields<CompanyModel> fields = const {
    #id: _f$id,
    #userId: _f$userId,
    #companyName: _f$companyName,
    #industry: _f$industry,
    #description: _f$description,
    #city: _f$city,
    #address: _f$address,
    #companySize: _f$companySize,
    #website: _f$website,
    #email: _f$email,
    #phone: _f$phone,
    #logoUrl: _f$logoUrl,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
  };

  static CompanyModel _instantiate(DecodingData data) {
    return CompanyModel(
      id: data.dec(_f$id),
      userId: data.dec(_f$userId),
      companyName: data.dec(_f$companyName),
      industry: data.dec(_f$industry),
      description: data.dec(_f$description),
      city: data.dec(_f$city),
      address: data.dec(_f$address),
      companySize: data.dec(_f$companySize),
      website: data.dec(_f$website),
      email: data.dec(_f$email),
      phone: data.dec(_f$phone),
      logoUrl: data.dec(_f$logoUrl),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CompanyModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CompanyModel>(map);
  }

  static CompanyModel fromJson(String json) {
    return ensureInitialized().decodeJson<CompanyModel>(json);
  }
}

mixin CompanyModelMappable {
  String toJson() {
    return CompanyModelMapper.ensureInitialized().encodeJson<CompanyModel>(
      this as CompanyModel,
    );
  }

  Map<String, dynamic> toMap() {
    return CompanyModelMapper.ensureInitialized().encodeMap<CompanyModel>(
      this as CompanyModel,
    );
  }

  CompanyModelCopyWith<CompanyModel, CompanyModel, CompanyModel> get copyWith =>
      _CompanyModelCopyWithImpl<CompanyModel, CompanyModel>(
        this as CompanyModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return CompanyModelMapper.ensureInitialized().stringifyValue(
      this as CompanyModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return CompanyModelMapper.ensureInitialized().equalsValue(
      this as CompanyModel,
      other,
    );
  }

  @override
  int get hashCode {
    return CompanyModelMapper.ensureInitialized().hashValue(
      this as CompanyModel,
    );
  }
}

extension CompanyModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CompanyModel, $Out> {
  CompanyModelCopyWith<$R, CompanyModel, $Out> get $asCompanyModel =>
      $base.as((v, t, t2) => _CompanyModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CompanyModelCopyWith<$R, $In extends CompanyModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? userId,
    String? companyName,
    String? industry,
    String? description,
    String? city,
    String? address,
    String? companySize,
    String? website,
    String? email,
    String? phone,
    String? logoUrl,
    String? createdAt,
    String? updatedAt,
  });
  CompanyModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CompanyModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CompanyModel, $Out>
    implements CompanyModelCopyWith<$R, CompanyModel, $Out> {
  _CompanyModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CompanyModel> $mapper =
      CompanyModelMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? userId,
    String? companyName,
    String? industry,
    String? description,
    String? city,
    Object? address = $none,
    Object? companySize = $none,
    Object? website = $none,
    Object? email = $none,
    Object? phone = $none,
    Object? logoUrl = $none,
    String? createdAt,
    String? updatedAt,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (userId != null) #userId: userId,
      if (companyName != null) #companyName: companyName,
      if (industry != null) #industry: industry,
      if (description != null) #description: description,
      if (city != null) #city: city,
      if (address != $none) #address: address,
      if (companySize != $none) #companySize: companySize,
      if (website != $none) #website: website,
      if (email != $none) #email: email,
      if (phone != $none) #phone: phone,
      if (logoUrl != $none) #logoUrl: logoUrl,
      if (createdAt != null) #createdAt: createdAt,
      if (updatedAt != null) #updatedAt: updatedAt,
    }),
  );
  @override
  CompanyModel $make(CopyWithData data) => CompanyModel(
    id: data.get(#id, or: $value.id),
    userId: data.get(#userId, or: $value.userId),
    companyName: data.get(#companyName, or: $value.companyName),
    industry: data.get(#industry, or: $value.industry),
    description: data.get(#description, or: $value.description),
    city: data.get(#city, or: $value.city),
    address: data.get(#address, or: $value.address),
    companySize: data.get(#companySize, or: $value.companySize),
    website: data.get(#website, or: $value.website),
    email: data.get(#email, or: $value.email),
    phone: data.get(#phone, or: $value.phone),
    logoUrl: data.get(#logoUrl, or: $value.logoUrl),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
  );

  @override
  CompanyModelCopyWith<$R2, CompanyModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CompanyModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

