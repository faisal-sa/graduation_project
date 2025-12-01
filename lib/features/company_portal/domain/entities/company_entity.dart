// lib/features/company_portal/domain/entities/company_entity.dart

import 'package:equatable/equatable.dart';

class CompanyEntity extends Equatable {
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
  final DateTime createdAt;
  final DateTime updatedAt;

  const CompanyEntity({
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

  CompanyEntity copyWith({
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
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CompanyEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      companyName: companyName ?? this.companyName,
      industry: industry ?? this.industry,
      description: description ?? this.description,
      city: city ?? this.city,
      address: address ?? this.address,
      companySize: companySize ?? this.companySize,
      website: website ?? this.website,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      logoUrl: logoUrl ?? this.logoUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    userId,
    companyName,
    industry,
    description,
    city,
    address,
    companySize,
    website,
    email,
    phone,
    logoUrl,
    createdAt,
    updatedAt,
  ];
}
