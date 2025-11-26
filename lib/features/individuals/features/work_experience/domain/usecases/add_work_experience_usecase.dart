import 'package:graduation_project/features/individuals/features/work_experience/domain/repositories/work_experience_repository.dart';
import 'package:injectable/injectable.dart';
import '../entities/work_experience.dart';

@lazySingleton
class AddWorkExperienceUseCase {
  final WorkExperienceRepository _repository;

  AddWorkExperienceUseCase(this._repository);

  Future<void> call(WorkExperience experience) async {
    return _repository.addWorkExperience(experience);
  }
}
