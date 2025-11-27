import 'package:multiple_result/multiple_result.dart';
import '../repositories/company_portal_repository.dart';

class CheckCompanyStatus {
  final CompanyRepository repo;
  CheckCompanyStatus(this.repo);

  Future<Result<(bool hasProfile, bool hasPaid), String>> call(
    String userId,
  ) async {
    // If you add a payments table later, extend the repository accordingly.
    // For now: a dummy implementation that just checks profile existence.
    final companyResult = await repo.getCompanyProfile(userId);
    return companyResult.when(
      (company) =>
          Success((true, false)), // change false → actual payment check
      (error) => Success((false, false)),
    );
  }
}
