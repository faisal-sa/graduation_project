import 'package:graduation_project/features/individuals/features/certifications/domain/entities/certification.dart';
import 'package:graduation_project/features/individuals/features/certifications/domain/repositories/certification_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddCertificationUseCase {
  final CertificationRepository repository;
  AddCertificationUseCase(this.repository);
  Future<Certification> call(Certification params) {
    return repository.addCertification(params);
  }
}
