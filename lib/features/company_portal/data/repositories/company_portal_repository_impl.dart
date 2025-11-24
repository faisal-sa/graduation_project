import 'package:graduation_project/features/company_portal/data/data_sources/company_portal_data_source.dart';
import 'package:graduation_project/features/company_portal/domain/repositories/company_portal_repository.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../domain/entities/company_entity.dart';

class CompanyRepositoryImpl implements CompanyRepository {
  final CompanyRemoteDataSource remote;
  CompanyRepositoryImpl(this.remote);

  @override
  Future<Result<CompanyEntity, String>> registerCompany({
    required String email,
    required String password,
  }) async {
    try {
      final company = await remote.registerCompany(email, password);
      return Success(company);
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<Result<CompanyEntity, String>> updateCompanyProfile(
    CompanyEntity company,
  ) async {
    try {
      final data = await remote.updateProfile(company);
      return Success(data);
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<Result<CompanyEntity, String>> getCompanyProfile(String userId) async {
    try {
      final data = await remote.getProfile(userId);
      return Success(data);
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<Result<List<Map<String, dynamic>>, String>> searchCandidates({
    String? city,
    String? skill,
    String? experience,
  }) async {
    try {
      final results = await remote.searchCandidates(
        city: city,
        skill: skill,
        experience: experience,
      );
      return Success(results);
    } catch (e) {
      return Error(e.toString());
    }
  }
}
