// lib/features/company_portal/data/repositories/company_repository_impl.dart

import 'package:dart_mappable/dart_mappable.dart';
import 'package:graduation_project/features/company_portal/data/data_sources/company_portal_data_source.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../../../core/error/failures.dart'; // Global Failures
import '../../domain/entities/candidate_entity.dart';
import '../../domain/entities/company_entity.dart';
import '../../domain/repositories/company_portal_repository.dart';
import '../models/candidate_model.dart';
import '../models/company_model.dart';

// --- Error Mapping Function ---
// Maps Data Layer Exceptions (like SupabaseException) to Domain Layer Failures.
Failure _mapExceptionToFailure(Exception e) {
  if (e is SupabaseException) {
    if (e.message.contains('not found') || e.message.contains('single row')) {
      return NotFoundFailure(e.message);
    }
    if (e.message.contains('Invalid uuid') ||
        e.message.contains('violates foreign key')) {
      return InvalidInputFailure(e.message);
    }
    if (e.message.contains('authentication')) {
      return AuthenticationFailure(e.message);
    }
    return ServerFailure(e.message);
  }
  return UnknownFailure(e.toString());
}

@Injectable(as: CompanyRepository)
class CompanyRepositoryImpl implements CompanyRepository {
  final CompanyRemoteDataSource remote;

  CompanyRepositoryImpl(this.remote);

  // Helper method to convert Entity back to a Map for Supabase updates
  Map<String, dynamic> _entityToMap(CompanyEntity entity) {
    // This map ensures only fields we want to update are sent to the Data Source
    return {
      'id': entity.id,
      'user_id': entity.userId,
      'company_name': entity.companyName,
      'industry': entity.industry,
      'description': entity.description,
      'city': entity.city,
      'address': entity.address,
      'company_size': entity.companySize,
      'website': entity.website,
      'email': entity.email,
      'phone': entity.phone,
      'logo_url': entity.logoUrl,
    };
  }

  // -----------------------------------------------------
  // Register new company
  // -----------------------------------------------------
  @override
  Future<Result<CompanyEntity, Failure>> registerCompany({
    required String email,
    required String password,
  }) async {
    try {
      final data = await remote.registerCompany(email, password);
      // Map Model to Entity
      final model = CompanyModelMapper.ensureInitialized().decodeMap(data);
      return Success(model.toEntity());
    } on Exception catch (e) {
      return Error(_mapExceptionToFailure(e));
    }
  }

  // -----------------------------------------------------
  // Get company profile by user id
  // -----------------------------------------------------
  @override
  Future<Result<CompanyEntity, Failure>> getCompanyProfile(
    String userId,
  ) async {
    try {
      final data = await remote.getCompanyProfile(userId);
      if (data == null)
        return Error(
          NotFoundFailure('Company profile not found for user ID: $userId'),
        );

      // Map Model to Entity
      final model = CompanyModelMapper.ensureInitialized().decodeMap(data);
      return Success(model.toEntity());
    } on Exception catch (e) {
      return Error(_mapExceptionToFailure(e));
    }
  }

  // -----------------------------------------------------
  // Update company profile
  // -----------------------------------------------------
  @override
  Future<Result<CompanyEntity, Failure>> updateCompanyProfile(
    CompanyEntity company,
  ) async {
    try {
      final updatedData = await remote.updateCompanyProfile(
        company.id,
        _entityToMap(company), // Convert Entity to Map for update payload
      );

      // Map Model to Entity
      final updatedModel = CompanyModelMapper.ensureInitialized().decodeMap(
        updatedData,
      );
      return Success(updatedModel.toEntity());
    } on Exception catch (e) {
      return Error(_mapExceptionToFailure(e));
    }
  }

  // -----------------------------------------------------
  // Search candidates (Returns Entities!)
  // -----------------------------------------------------
  @override
  Future<Result<List<CandidateEntity>, Failure>> searchCandidates({
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

      // Map raw data to CandidateModel and then to CandidateEntity
      final entities = results.map<CandidateEntity>((data) {
        // Explicit type argument fixes List<dynamic> error
        final model = CandidateModelMapper.ensureInitialized().decodeMap(data);
        return model.toEntity();
      }).toList();

      return Success(entities);
    } on Exception catch (e) {
      return Error(_mapExceptionToFailure(e));
    }
  }

  // -----------------------------------------------------
  // Add candidate bookmark
  // -----------------------------------------------------
  @override
  Future<Result<void, Failure>> addCandidateBookmark(
    String companyId,
    String candidateId,
  ) async {
    try {
      await remote.addCandidateBookmark(companyId, candidateId);
      return const Success(null);
    } on Exception catch (e) {
      return Error(_mapExceptionToFailure(e));
    }
  }

  // -----------------------------------------------------
  // Get Company Bookmarks (Returns Entities!)
  // -----------------------------------------------------
  @override
  Future<Result<List<CandidateEntity>, Failure>> getCompanyBookmarks(
    String companyId,
  ) async {
    try {
      final results = await remote.getCompanyBookmarks(companyId);

      // Map raw join data to CandidateEntity
      final entities = results.map<CandidateEntity>((data) {
        // Explicit type argument
        // Handle the join structure: 'candidate_id, candidates(full_name, ...)'
        final candidateData = data['candidates'] as Map<String, dynamic>?;
        final candidateId = data['candidate_id'] as String;

        return CandidateEntity(
          id: candidateId,
          fullName:
              candidateData?['full_name'] as String? ?? 'Unknown Candidate',
          skills: candidateData?['skills'] as String?,
          city: candidateData?['city'] as String?,
        );
      }).toList();

      return Success(entities);
    } on Exception catch (e) {
      return Error(_mapExceptionToFailure(e));
    }
  }

  // -----------------------------------------------------
  // Check Company Status
  // -----------------------------------------------------
  @override
  Future<Result<Map<String, bool>, Failure>> checkCompanyStatus(
    String userId,
  ) async {
    try {
      final statusData = await remote.checkCompanyStatus(userId);
      return Success({
        'hasProfile': statusData['hasProfile'] as bool,
        'hasPaid': statusData['hasPaid'] as bool,
      });
    } on Exception catch (e) {
      return Error(_mapExceptionToFailure(e));
    }
  }
}
