import 'package:multiple_result/multiple_result.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Result<User, Failure>> signUp({
    required String email,
    required String password,
    required String role,
  });

  Future<Result<User, Failure>> signIn({
    required String email,
    required String password,
  });

  Future<Result<void, Failure>> signOut();

  Future<Result<void, Failure>> sendOTP({required String email});

  Future<Result<void, Failure>> resendOTP({required String email});

  Future<Result<User, Failure>> verifyOTP({
    required String email,
    required String token,
  });

  Future<Result<User?, Failure>> getCurrentUser();
}
