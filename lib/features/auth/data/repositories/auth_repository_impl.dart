import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  /// Extracts a user-friendly error message from exceptions
  String _getErrorMessage(dynamic error, String defaultMessage) {
    if (error is supabase.AuthException) {
      // Handle rate limit errors specifically (statusCode can be int or String)
      final statusCode = error.statusCode?.toString() ?? '';
      if (statusCode == '429' ||
          error.message.toLowerCase().contains('rate') ||
          error.message.toLowerCase().contains('seconds') ||
          error.message.toLowerCase().contains('too many')) {
        // Extract wait time from message if available
        final waitTimeMatch = RegExp(
          r'(\d+)\s*seconds?',
        ).firstMatch(error.message);
        if (waitTimeMatch != null) {
          final seconds = waitTimeMatch.group(1);
          return 'Please wait $seconds seconds before trying again. This helps protect your account security.';
        }
        return 'Too many requests. Please wait a moment before trying again.';
      }
      return error.message;
    } else if (error is Exception) {
      final message = error.toString();
      // Extract meaningful message from exception
      if (message.contains('Sign up failed')) {
        return 'Failed to create account. Please try again.';
      } else if (message.contains('Sign in failed')) {
        return 'Invalid email or password. Please check your credentials.';
      } else if (message.contains('OTP verification failed')) {
        return 'Invalid OTP code. Please try again.';
      } else if (message.contains('Password reset')) {
        return 'Failed to reset password. Please try again.';
      } else if (message.contains('Password update failed')) {
        return 'Failed to update password. Please try again.';
      } else if (message.contains('network') ||
          message.contains('connection')) {
        return 'Network error. Please check your internet connection.';
      } else if (message.contains('rate') || message.contains('seconds')) {
        return 'Too many requests. Please wait a moment before trying again.';
      }
      // Return the exception message if it's clear, otherwise use default
      return message
          .replaceFirst('Exception: ', '')
          .replaceFirst('Error: ', '');
    }
    return defaultMessage;
  }

  /// Extracts error message without rate limit transformation (for OTP operations)
  String _getErrorMessageWithoutRateLimit(
    dynamic error,
    String defaultMessage,
  ) {
    if (error is supabase.AuthException) {
      // Just return the original message without rate limit transformation
      return error.message;
    } else if (error is Exception) {
      final message = error.toString();
      // Extract meaningful message from exception
      if (message.contains('Sign up failed')) {
        return 'Failed to create account. Please try again.';
      } else if (message.contains('Sign in failed')) {
        return 'Invalid email or password. Please check your credentials.';
      } else if (message.contains('OTP verification failed')) {
        return 'Invalid OTP code. Please try again.';
      } else if (message.contains('Password reset')) {
        return 'Failed to reset password. Please try again.';
      } else if (message.contains('Password update failed')) {
        return 'Failed to update password. Please try again.';
      } else if (message.contains('network') ||
          message.contains('connection')) {
        return 'Network error. Please check your internet connection.';
      }
      // Return the exception message if it's clear, otherwise use default
      return message
          .replaceFirst('Exception: ', '')
          .replaceFirst('Error: ', '');
    }
    return defaultMessage;
  }

  @override
  Future<Result<User, Failure>> signUp({
    required String email,
    required String password,
    required String role,
  }) async {
    print('[Repository] signUp called');
    print('[Repository] Email: $email, Role: $role');
    try {
      print('[Repository] Calling remoteDataSource.signUp...');
      final userModel = await remoteDataSource.signUp(
        email: email,
        password: password,
        role: role,
      );
      print('[Repository] RemoteDataSource signUp successful');
      print('[Repository] User ID: ${userModel.id}');
      return Success(userModel.toEntity());
    } catch (e) {
      print('[Repository] signUp failed with error: $e');
      print('[Repository] Error type: ${e.runtimeType}');
      print('[Repository] Error stack: ${StackTrace.current}');
      return Error(
        ServerFailure(
          _getErrorMessage(e, 'Failed to create account. Please try again.'),
        ),
      );
    }
  }

  @override
  Future<Result<User, Failure>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await remoteDataSource.signIn(
        email: email,
        password: password,
      );
      return Success(userModel.toEntity());
    } catch (e) {
      return Error(
        ServerFailure(
          _getErrorMessage(
            e,
            'Invalid email or password. Please check your credentials.',
          ),
        ),
      );
    }
  }

  @override
  Future<Result<void, Failure>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return const Success(null);
    } catch (e) {
      return Error(
        ServerFailure(
          _getErrorMessage(e, 'Failed to sign out. Please try again.'),
        ),
      );
    }
  }

  @override
  Future<Result<void, Failure>> sendOTP({required String email}) async {
    try {
      await remoteDataSource.sendOTP(email: email);
      return const Success(null);
    } catch (e) {
      return Error(
        ServerFailure(
          _getErrorMessageWithoutRateLimit(
            e,
            'Failed to send verification code. Please try again.',
          ),
        ),
      );
    }
  }

  @override
  Future<Result<void, Failure>> resendOTP({required String email}) async {
    try {
      await remoteDataSource.resendOTP(email: email);
      return const Success(null);
    } catch (e) {
      return Error(
        ServerFailure(
          _getErrorMessageWithoutRateLimit(
            e,
            'Failed to resend verification code. Please try again.',
          ),
        ),
      );
    }
  }

  @override
  Future<Result<User, Failure>> verifyOTP({
    required String email,
    required String token,
  }) async {
    try {
      final userModel = await remoteDataSource.verifyOTP(
        email: email,
        token: token,
      );
      return Success(userModel.toEntity());
    } catch (e) {
      return Error(
        ServerFailure(
          _getErrorMessage(
            e,
            'Invalid verification code. Please check and try again.',
          ),
        ),
      );
    }
  }

  @override
  Future<Result<void, Failure>> resetPassword({required String email}) async {
    try {
      await remoteDataSource.resetPassword(email: email);
      return const Success(null);
    } catch (e) {
      return Error(
        ServerFailure(
          _getErrorMessage(
            e,
            'Failed to send password reset email. Please try again.',
          ),
        ),
      );
    }
  }

  @override
  Future<Result<void, Failure>> sendPasswordResetOTP({
    required String email,
  }) async {
    try {
      await remoteDataSource.sendPasswordResetOTP(email: email);
      return const Success(null);
    } catch (e) {
      return Error(
        ServerFailure(
          _getErrorMessage(
            e,
            'Failed to send password reset code. Please try again.',
          ),
        ),
      );
    }
  }

  @override
  Future<Result<User, Failure>> verifyPasswordResetOTP({
    required String email,
    required String token,
  }) async {
    try {
      final userModel = await remoteDataSource.verifyPasswordResetOTP(
        email: email,
        token: token,
      );
      return Success(userModel.toEntity());
    } catch (e) {
      return Error(
        ServerFailure(
          _getErrorMessage(
            e,
            'Invalid password reset code. Please check and try again.',
          ),
        ),
      );
    }
  }

  @override
  Future<Result<User, Failure>> updatePassword({
    required String newPassword,
  }) async {
    try {
      final userModel = await remoteDataSource.updatePassword(
        newPassword: newPassword,
      );
      return Success(userModel.toEntity());
    } catch (e) {
      return Error(
        ServerFailure(
          _getErrorMessage(e, 'Failed to update password. Please try again.'),
        ),
      );
    }
  }

  @override
  Future<Result<User?, Failure>> getCurrentUser() async {
    try {
      final userModel = await remoteDataSource.getCurrentUser();
      return Success(userModel?.toEntity());
    } catch (e) {
      return Error(
        ServerFailure(
          _getErrorMessage(
            e,
            'Failed to retrieve user information. Please try again.',
          ),
        ),
      );
    }
  }
}
