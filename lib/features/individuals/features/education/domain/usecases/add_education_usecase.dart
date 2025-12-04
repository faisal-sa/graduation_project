import 'package:injectable/injectable.dart';
import '../entities/education.dart';
import '../repositories/education_repository.dart';

@lazySingleton
class AddEducationUseCase {
  final EducationRepository _repository;

  AddEducationUseCase(this._repository);

  Future<void> call(Education education) {
    return _repository.addEducation(education);
  }
}
