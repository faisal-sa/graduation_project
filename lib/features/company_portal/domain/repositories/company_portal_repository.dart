// lib/features/company_portal/domain/repositories/company_portal_repository.dart

import 'package:multiple_result/multiple_result.dart';
import '../../../../core/error/failures.dart';
import '../entities/candidate_entity.dart';
import '../entities/company_entity.dart';

abstract class CompanyRepository {
  // Using Future<Result<T, Failure>> directly
  Future<Result<CompanyEntity, Failure>> registerCompany({
    required String email,
    required String password,
  });

  Future<Result<CompanyEntity, Failure>> getCompanyProfile(String userId);

  Future<Result<CompanyEntity, Failure>> updateCompanyProfile(
    CompanyEntity company,
  );

  Future<Result<List<CandidateEntity>, Failure>> searchCandidates({
    String? city,
    String? skill,
    String? experience,
  });

  Future<Result<void, Failure>> addCandidateBookmark(
    String companyId,
    String candidateId,
  );

  Future<Result<List<CandidateEntity>, Failure>> getCompanyBookmarks(
    String companyId,
  );

  Future<Result<Map<String, bool>, Failure>> checkCompanyStatus(String userId);
}
