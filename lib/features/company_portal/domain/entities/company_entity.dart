class CompanyEntity {
  final String id;
  final String userId;
  final String companyName;
  final String industry;
  final String description;
  final String city;
  final String? address;
  final String companySize;
  final String website;
  final String email;
  final String phone;
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
    required this.companySize,
    required this.website,
    required this.email,
    required this.phone,
    this.logoUrl,
    required this.createdAt,
    required this.updatedAt,
  });
}
