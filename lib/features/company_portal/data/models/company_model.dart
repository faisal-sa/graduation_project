import 'package:dart_mappable/dart_mappable.dart';
import '../../domain/entities/company_entity.dart';

part 'company_model.mapper.dart';

@MappableClass()
class CompanyModel with CompanyModelMappable {
  final String id;
  @MappableField(key: 'user_id')
  final String userId;
  @MappableField(key: 'company_name')
  final String companyName;
  final String industry;
  final String description;
  final String city;
  final String? address;
  @MappableField(key: 'company_size')
  final String? companySize;
  final String? website;
  final String? email;
  final String? phone;
  @MappableField(key: 'logo_url')
  final String? logoUrl;
  @MappableField(key: 'created_at')
  final String createdAt;
  @MappableField(key: 'updated_at')
  final String updatedAt;

  const CompanyModel({
    required this.id,
    required this.userId,
    required this.companyName,
    required this.industry,
    required this.description,
    required this.city,
    this.address,
    this.companySize,
    this.website,
    this.email,
    this.phone,
    this.logoUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  CompanyEntity toEntity() => CompanyEntity(
    companyName: companyName,
    industry: industry,
    description: description,
    city: city,
    address: address,
    companySize: companySize,
    website: website,
    email: email,
    phone: phone,
    logoUrl: logoUrl,
    createdAt: DateTime.tryParse(createdAt) ?? DateTime(1970),
    updatedAt: DateTime.tryParse(updatedAt) ?? DateTime(1970),
  );

  @override
  Map<String, dynamic> toMap() =>
      CompanyModelMapper.ensureInitialized().encodeMap(this);
}
