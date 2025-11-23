import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String? phone;

  const UserModel({
    required this.id,
    required this.email,
    this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
    );
  }

  User toEntity() {
    return User(
      id: id,
      email: email,
      phone: phone,
    );
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      email: user.email,
      phone: user.phone,
    );
  }

  @override
  List<Object?> get props => [id, email, phone];
}

