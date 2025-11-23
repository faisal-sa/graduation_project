import 'package:dart_mappable/dart_mappable.dart';
import '../../domain/entities/company_entity.dart';

part 'company_model.mapper.dart';

@MappableClass()
class CompanyModel with CompanyModelMappable {
  final String id;
  final String user_id;
  final String company_name;
  final String industry;
  final String description;
  final String city;
  final String? address;
  final String company_size;
  final String website;
  final String email;
  final String phone;
  final String? logo_url;
  final String created_at;
  final String updated_at;

  const CompanyModel({
    required this.id,
    required this.user_id,
    required this.company_name,
    required this.industry,
    required this.description,
    required this.city,
    this.address,
    required this.company_size,
    required this.website,
    required this.email,
    required this.phone,
    this.logo_url,
    required this.created_at,
    required this.updated_at,
  });

  CompanyEntity toEntity() => CompanyEntity(
    id: id,
    userId: user_id,
    companyName: company_name,
    industry: industry,
    description: description,
    city: city,
    address: address,
    companySize: company_size,
    website: website,
    email: email,
    phone: phone,
    logoUrl: logo_url,
    createdAt: DateTime.parse(created_at),
    updatedAt: DateTime.parse(updated_at),
  );
}
