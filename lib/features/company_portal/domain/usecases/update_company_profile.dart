import 'package:graduation_project/features/company_portal/domain/repositories/company_portal_repository.dart';
import 'package:multiple_result/multiple_result.dart';
import '../entities/company_entity.dart';

class UpdateCompanyProfile {
  final CompanyRepository repo;
  UpdateCompanyProfile(this.repo);

  Future<Result<CompanyEntity, String>> call(CompanyEntity company) {
    return repo.updateCompanyProfile(company);
  }
}
