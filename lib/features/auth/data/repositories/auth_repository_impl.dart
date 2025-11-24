import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Result<User, Failure>> signUp({
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      final userModel = await remoteDataSource.signUp(
        email: email,
        password: password,
        role: role,
      );
      return Success(userModel.toEntity());
    } catch (e) {
      return Error(ServerFailure(e.toString()));
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
      return Error(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<void, Failure>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return const Success(null);
    } catch (e) {
      return Error(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<void, Failure>> sendOTP({required String email}) async {
    try {
      await remoteDataSource.sendOTP(email: email);
      return const Success(null);
    } catch (e) {
      return Error(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<void, Failure>> resendOTP({required String email}) async {
    try {
      await remoteDataSource.resendOTP(email: email);
      return const Success(null);
    } catch (e) {
      return Error(ServerFailure(e.toString()));
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
      return Error(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<User?, Failure>> getCurrentUser() async {
    try {
      final userModel = await remoteDataSource.getCurrentUser();
      return Success(userModel?.toEntity());
    } catch (e) {
      return Error(ServerFailure(e.toString()));
    }
  }
}
