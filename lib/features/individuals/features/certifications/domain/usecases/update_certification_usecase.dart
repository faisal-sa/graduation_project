import 'package:graduation_project/features/individuals/features/certifications/domain/entities/certification.dart';
import 'package:graduation_project/features/individuals/features/certifications/domain/repositories/certification_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateCertificationUseCase {
  final CertificationRepository repository;
  UpdateCertificationUseCase(this.repository);
  Future<void> call(Certification cert) => repository.updateCertification(cert);
}
