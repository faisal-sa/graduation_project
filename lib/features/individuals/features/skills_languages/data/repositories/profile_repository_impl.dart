import 'package:fpdart/fpdart.dart';
import 'package:graduation_project/core/error/failures.dart';
import 'package:graduation_project/features/individuals/features/skills_languages/data/datasources/skills_languages_remote_data_source.dart';
import 'package:graduation_project/features/individuals/features/skills_languages/domain/entities/user_profile.dart';
import 'package:graduation_project/features/individuals/features/skills_languages/domain/repositories/skills_languages_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SkillsLanguagesRepository)
class SkillsLanguagesRepositoryImpl implements SkillsLanguagesRepository {
  final SkillsLanguagesRemoteDataSource _dataSource;

  SkillsLanguagesRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, Unit>> updateSkills(List<String> skills) async {
    try {
      await _dataSource.updateSkills(skills);
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateLanguages(List<String> languages) async {
    try {
      await _dataSource.updateLanguages(languages);
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SkillsAndLanguages>> getData() async {
    try {
      final profile = await _dataSource.getData();
      return Right(profile);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
