import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';

enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error,
  otpSent,
  otpVerified,
  passwordResetEmailSent,
  passwordResetVerified,
}

class AuthState extends Equatable {
  final AuthStatus status;
  final User? user;
  final String? message;
  final String? email;
  final String? role;
  final String? userId;

  const AuthState({
    required this.status,
    this.user,
    this.message,
    this.email,
    this.role,
    this.userId,
  });

  factory AuthState.initial() => const AuthState(status: AuthStatus.initial);

  factory AuthState.loading() => const AuthState(status: AuthStatus.loading);

  factory AuthState.authenticated(User user, {String? role}) => AuthState(
    status: AuthStatus.authenticated,
    user: user,
    role: role ?? user.role,
    userId: user.id,
  );

  factory AuthState.unauthenticated() =>
      const AuthState(status: AuthStatus.unauthenticated);

  factory AuthState.error(String message) =>
      AuthState(status: AuthStatus.error, message: message);

  factory AuthState.otpSent(String email) =>
      AuthState(status: AuthStatus.otpSent, email: email);

  factory AuthState.otpVerified(User user) =>
      AuthState(status: AuthStatus.otpVerified, user: user);

  factory AuthState.passwordResetEmailSent(String email) =>
      AuthState(status: AuthStatus.passwordResetEmailSent, email: email);

  factory AuthState.passwordResetVerified(User user) =>
      AuthState(status: AuthStatus.passwordResetVerified, user: user);

  @override
  List<Object?> get props => [status, user, message, email, role, userId];
}
