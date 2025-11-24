import 'package:graduation_project/features/company_portal/domain/repositories/company_portal_repository.dart';
import 'package:multiple_result/multiple_result.dart';
import '../entities/company_entity.dart';

class RegisterCompany {
  final CompanyRepository repo;
  RegisterCompany(this.repo);

  Future<Result<CompanyEntity, String>> call({
    required String email,
    required String password,
  }) {
    return repo.registerCompany(email: email, password: password);
  }
}
