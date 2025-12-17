import 'package:equatable/equatable.dart';
import 'package:graduation_project/features/auth/domain/entities/user.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String role;
  final String? phone;
  final String? crNumber;

  const UserModel({
    required this.id,
    required this.email,
    required this.role,
    this.phone,
    this.crNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      role: json['role'] as String? ?? 'user',
      phone: json['phone'] as String?,
      crNumber: json['crNumber'] as String?,
    );
  }

  User toEntity() {
    return User(id: id, email: email, role: role, phone: phone);
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      email: user.email,
      role: user.role,
      phone: user.phone,
    );
  }

  @override
  List<Object?> get props => [id, email, role, phone];
}
