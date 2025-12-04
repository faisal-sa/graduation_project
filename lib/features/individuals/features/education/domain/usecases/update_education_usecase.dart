import 'package:injectable/injectable.dart';
import '../entities/education.dart';
import '../repositories/education_repository.dart';

@lazySingleton
class UpdateEducationUseCase {
  final EducationRepository _repository;

  UpdateEducationUseCase(this._repository);

  Future<void> call(Education education) {
    return _repository.updateEducation(education);
  }
}
