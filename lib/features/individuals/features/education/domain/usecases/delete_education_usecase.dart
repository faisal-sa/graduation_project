import 'package:injectable/injectable.dart';
import '../repositories/education_repository.dart';

@lazySingleton
class DeleteEducationUseCase {
  final EducationRepository _repository;

  DeleteEducationUseCase(this._repository);

  Future<void> call(String id) {
    return _repository.deleteEducation(id);
  }
}
