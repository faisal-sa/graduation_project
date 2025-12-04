import 'package:dartz/dartz.dart';
import 'package:graduation_project/core/error/failures.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/job_preferences_entity.dart';
import '../../domain/repositories/job_preferences_repository.dart';
import '../datasources/job_preferences_remote_datasource.dart';
import '../models/job_preferences_model.dart';

@LazySingleton(as: JobPreferencesRepository)
class JobPreferencesRepositoryImpl implements JobPreferencesRepository {
  final JobPreferencesRemoteDataSource remoteDataSource;

  JobPreferencesRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, JobPreferencesEntity>> getJobPreferences() async {
    try {
      final result = await remoteDataSource.getPreferences();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateJobPreferences(
    JobPreferencesEntity preferences,
  ) async {
    try {
      final model = JobPreferencesModel.fromEntity(preferences);
      await remoteDataSource.updatePreferences(model);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
