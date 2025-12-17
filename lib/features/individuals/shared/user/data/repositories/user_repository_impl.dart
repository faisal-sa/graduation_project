import 'dart:typed_data';

import 'package:graduation_project/features/individuals/shared/user/data/datasources/ai_datasource.dart';
import 'package:graduation_project/features/individuals/shared/user/data/datasources/user_local_datasource.dart';
import 'package:graduation_project/features/individuals/shared/user/data/datasources/user_remote_datasource.dart';
import 'package:graduation_project/features/individuals/shared/user/domain/entities/user_entity.dart';
import 'package:graduation_project/features/individuals/shared/user/domain/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final AIDataSource aiDataSource;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.aiDataSource,
  });

  @override
  Future<UserEntity?> getLastLocalUser() async {
    return await localDataSource.getLastUser();
  }

  @override
  Future<void> cacheUser(UserEntity user) async {
    await localDataSource.cacheUser(user);
  }

  @override
  Future<UserEntity> fetchRemoteProfile(String userId) async {
    final user = await remoteDataSource.fetchProfile(userId);
    await localDataSource.cacheUser(user);
    return user;
  }

  @override
  Future<void> updateRemoteProfile(UserEntity user) async {
    await remoteDataSource.updateProfile(user);
  }

  @override
  Future<UserEntity> extractResumeData(Uint8List fileBytes) async {
    return await aiDataSource.extractResume(fileBytes);
  }
}