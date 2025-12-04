import 'package:dartz/dartz.dart';
import 'package:graduation_project/core/error/failures.dart';
import '../entities/job_preferences_entity.dart';

abstract class JobPreferencesRepository {
  Future<Either<Failure, JobPreferencesEntity>> getJobPreferences();
  Future<Either<Failure, void>> updateJobPreferences(
    JobPreferencesEntity preferences,
  );
}
