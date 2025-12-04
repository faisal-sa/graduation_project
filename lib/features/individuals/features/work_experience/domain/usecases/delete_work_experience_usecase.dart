import 'package:graduation_project/features/individuals/features/work_experience/domain/repositories/work_experience_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeleteWorkExperienceUseCase {
  final WorkExperienceRepository _repository;

  DeleteWorkExperienceUseCase(this._repository);

  Future<void> call(String id) async {
    return _repository.deleteWorkExperience(id);
  }
}
