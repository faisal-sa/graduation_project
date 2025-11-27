import 'package:dart_mappable/dart_mappable.dart';
import '../../domain/entities/company_entity.dart';

part 'company_model.mapper.dart';

@MappableClass()
class CompanyModel with CompanyModelMappable {
  final String id;
  final String userId;
  final String companyName;
  final String industry;
  final String description;
  final String city;
  final String? address;
  final String? companySize;
  final String? website;
  final String? email;
  final String? phone;
  final String? logoUrl;
  final String createdAt;
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

  /// Model → Entity
  CompanyEntity toEntity() => CompanyEntity(
    id: id,
    userId: userId,
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
    createdAt: DateTime.tryParse(createdAt) ?? DateTime.now(),
    updatedAt: DateTime.tryParse(updatedAt) ?? DateTime.now(),
  );

  /// Entity → Model
  static CompanyModel fromEntity(CompanyEntity entity) => CompanyModel(
    id: entity.id,
    userId: entity.userId,
    companyName: entity.companyName,
    industry: entity.industry,
    description: entity.description,
    city: entity.city,
    address: entity.address,
    companySize: entity.companySize,
    website: entity.website,
    email: entity.email,
    phone: entity.phone,
    logoUrl: entity.logoUrl,
    createdAt: entity.createdAt.toIso8601String(),
    updatedAt: entity.updatedAt.toIso8601String(),
  );

  Map<String, dynamic> toMap() =>
      CompanyModelMapper.ensureInitialized().encodeMap(this);
}
