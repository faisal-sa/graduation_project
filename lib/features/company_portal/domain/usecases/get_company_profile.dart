import 'package:multiple_result/multiple_result.dart';
import '../entities/company_entity.dart';
import '../repositories/company_portal_repository.dart';

class GetCompanyProfile {
  final CompanyRepository repo;
  GetCompanyProfile(this.repo);

  Future<Result<CompanyEntity, String>> call(String userId) {
    return repo.getCompanyProfile(userId);
  }
}
