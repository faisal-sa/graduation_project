import 'package:injectable/injectable.dart';
import '../entities/education.dart';
import '../repositories/education_repository.dart';

@lazySingleton
class GetEducationsUseCase {
  final EducationRepository _repository;

  GetEducationsUseCase(this._repository);

  Future<List<Education>> call() {
    return _repository.getEducations();
  }
}
