import 'package:multiple_result/multiple_result.dart';
import '../../domain/entities/company_entity.dart';
import '../../domain/repositories/company_portal_repository.dart';
import '../data_sources/company_portal_data_source.dart';
import '../models/company_model.dart';

class CompanyRepositoryImpl implements CompanyRepository {
  final CompanyRemoteDataSource remote;

  CompanyRepositoryImpl(this.remote);

  // -----------------------------------------------------
  // Register new company
  // -----------------------------------------------------
  @override
  Future<Result<CompanyEntity, String>> registerCompany({
    required String email,
    required String password,
  }) async {
    try {
      final data = await remote.registerCompany(email, password);

      // Map → Model → Entity
      final model = CompanyModelMapper.ensureInitialized().decodeMap(data);
      return Success(model.toEntity());
    } catch (e) {
      return Error(e.toString());
    }
  }

  // -----------------------------------------------------
  // Get company profile by user id
  // -----------------------------------------------------
  @override
  Future<Result<CompanyEntity, String>> getCompanyProfile(String userId) async {
    try {
      final data = await remote.getCompanyProfile(userId);
      if (data == null) return Error('Company not found');

      final model = CompanyModelMapper.ensureInitialized().decodeMap(data);
      return Success(model.toEntity());
    } catch (e) {
      return Error(e.toString());
    }
  }

  // -----------------------------------------------------
  // Update company profile
  // -----------------------------------------------------
  @override
  Future<Result<CompanyEntity, String>> updateCompanyProfile(
    CompanyEntity company,
  ) async {
    try {
      final model = CompanyModel.fromEntity(company);
      final updatedData = await remote.updateCompanyProfile(
        model.id,
        model.toMap(),
      );

      final updatedModel = CompanyModelMapper.ensureInitialized().decodeMap(
        updatedData,
      );
      return Success(updatedModel.toEntity());
    } catch (e) {
      return Error(e.toString());
    }
  }

  // -----------------------------------------------------
  // Search candidates by filters
  // -----------------------------------------------------
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

  // -----------------------------------------------------
  // Add candidate bookmark
  // -----------------------------------------------------
  @override
  Future<Result<void, String>> addCandidateBookmark(
    String companyId,
    String candidateId,
  ) async {
    try {
      await remote.addCandidateBookmark(companyId, candidateId);
      return const Success(null);
    } catch (e) {
      return Error(e.toString());
    }
  }
}
