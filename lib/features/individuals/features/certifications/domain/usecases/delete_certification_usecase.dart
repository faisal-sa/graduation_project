import 'package:graduation_project/features/individuals/features/certifications/domain/repositories/certification_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteCertificationUseCase {
  final CertificationRepository repository;
  DeleteCertificationUseCase(this.repository);
  Future<void> call(String id) => repository.deleteCertification(id);
}
