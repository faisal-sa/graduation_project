import 'package:graduation_project/features/auth/domain/entities/user.dart';

class UserModel {
  final String id;
  final String email;
  final String? phone;
  final String role;

  UserModel({
    required this.id,
    required this.email,
    this.phone,
    required this.role,
  });

  User toEntity() => User(id: id, email: email, phone: phone, role: role);
}
