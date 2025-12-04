import 'package:graduation_project/features/individuals/features/basic_info/domain/entities/basic_info_entity.dart';

class BasicInfoModel extends BasicInfoEntity {
  const BasicInfoModel({
    required super.firstName,
    required super.lastName,
    required super.jobTitle,
    required super.phoneNumber,
    required super.email,
    required super.location,
  });

  factory BasicInfoModel.fromEntity(BasicInfoEntity entity) {
    return BasicInfoModel(
      firstName: entity.firstName,
      lastName: entity.lastName,
      jobTitle: entity.jobTitle,
      phoneNumber: entity.phoneNumber,
      email: entity.email,
      location: entity.location,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'job_title': jobTitle,
      'phone_number': phoneNumber,
      'email': email,
      'location': location,
      'updated_at': DateTime.now().toIso8601String(),
    };
  }
}
