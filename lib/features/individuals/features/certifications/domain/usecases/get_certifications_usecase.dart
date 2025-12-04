import 'package:graduation_project/features/individuals/features/certifications/domain/entities/certification.dart';
import 'package:graduation_project/features/individuals/features/certifications/domain/repositories/certification_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCertificationsUseCase {
  final CertificationRepository repository;
  GetCertificationsUseCase(this.repository);
  Future<List<Certification>> call() => repository.getCertifications();
}
