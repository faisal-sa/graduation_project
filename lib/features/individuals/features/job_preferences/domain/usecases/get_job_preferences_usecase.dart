import 'package:dartz/dartz.dart';
import 'package:graduation_project/core/error/failures.dart';
import 'package:graduation_project/features/individuals/features/job_preferences/domain/entities/job_preferences_entity.dart';
import 'package:graduation_project/features/individuals/features/job_preferences/domain/repositories/job_preferences_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetJobPreferencesUseCase {
  final JobPreferencesRepository repository;

  GetJobPreferencesUseCase(this.repository);

  Future<Either<Failure, JobPreferencesEntity>> call() async {
    return await repository.getJobPreferences();
  }
}
