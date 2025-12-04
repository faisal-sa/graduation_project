import 'package:graduation_project/features/individuals/features/certifications/domain/entities/certification.dart';

abstract class CertificationRepository {
  Future<List<Certification>> getCertifications();
  Future<void> addCertification(Certification certification);
  Future<void> updateCertification(Certification certification);
  Future<void> deleteCertification(String id);
}
