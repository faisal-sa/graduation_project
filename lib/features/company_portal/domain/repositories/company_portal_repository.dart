import 'package:multiple_result/multiple_result.dart';
import '../entities/company_entity.dart';

abstract class CompanyRepository {
  Future<Result<CompanyEntity, String>> registerCompany({
    required String email,
    required String password,
  });

  Future<Result<CompanyEntity, String>> updateCompanyProfile(
    CompanyEntity company,
  );

  Future<Result<CompanyEntity, String>> getCompanyProfile(String userId);

  Future<Result<List<Map<String, dynamic>>, String>> searchCandidates({
    String? city,
    String? skill,
    String? experience,
  });
}
