import 'package:dartz/dartz.dart';
import 'package:graduation_project/core/error/failures.dart';
import 'package:injectable/injectable.dart';
import '../entities/job_preferences_entity.dart';
import '../repositories/job_preferences_repository.dart';

@lazySingleton
class UpdateJobPreferencesUseCase {
  final JobPreferencesRepository repository;

  UpdateJobPreferencesUseCase(this.repository);

  Future<Either<Failure, void>> call(JobPreferencesEntity preferences) async {
    return await repository.updateJobPreferences(preferences);
  }
}
