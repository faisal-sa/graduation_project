import 'package:graduation_project/features/individuals/features/work_experience/domain/repositories/work_experience_repository.dart';
import 'package:injectable/injectable.dart';
import '../entities/work_experience.dart';

@lazySingleton
class GetWorkExperiencesUseCase {
  final WorkExperienceRepository _repository;

  GetWorkExperiencesUseCase(this._repository);

  Future<List<WorkExperience>> call() async {
    return _repository.getWorkExperiences();
  }
}
