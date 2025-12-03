import 'package:graduation_project/features/company_portal/data/data_sources/company_portal_data_source.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/candidate_entity.dart';
import '../../domain/entities/company_entity.dart';
import '../../domain/repositories/company_portal_repository.dart';
import '../models/candidate_model.dart';
import '../models/company_model.dart';

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

  Map<String, dynamic> _entityToMap(CompanyEntity entity) {
    return {
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

  @override
  Future<Result<CompanyEntity, Failure>> registerCompany({
    required String email,
    required String password,
  }) async {
    try {
      final data = await remote.registerCompany(email, password);
      final model = CompanyModelMapper.ensureInitialized().decodeMap(data);
      return Success(model.toEntity());
    } on Exception catch (e) {
      return Error(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<CompanyEntity, Failure>> getCompanyProfile(
    String userId,
  ) async {
    try {
      final data = await remote.getCompanyProfile(userId);
      if (data == null) {
        return Error(
          NotFoundFailure('Company profile not found for user ID: $userId'),
        );
      }
      final model = CompanyModelMapper.ensureInitialized().decodeMap(data);
      return Success(model.toEntity());
    } on Exception catch (e) {
      return Error(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<CompanyEntity, Failure>> updateCompanyProfile(
    CompanyEntity company,
  ) async {
    try {
      final updatePayload = _entityToMap(company);

      final updatedData = await remote.updateCompanyProfile(updatePayload);
      final CompanyModel updatedModel = CompanyModelMapper.ensureInitialized()
          .decodeMap(updatedData);
      return Success(updatedModel.toEntity());
    } on Exception catch (e) {
      return Error(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<List<CandidateEntity>, Failure>> searchCandidates({
    String? location,
    List<String>? skills,
    List<String>? employmentTypes,
    bool? canRelocate,
    List<String>? languages,
    List<String>? workModes,
    String? jobTitle,
    List<String>? targetRoles,
  }) async {
    try {
      final results = await remote.searchCandidates(
        location: location,
        skills: skills,
        employmentTypes: employmentTypes,
        canRelocate: canRelocate,
        languages: languages,
        workModes: workModes,
        jobTitle: jobTitle,
        targetRoles: targetRoles,
      );
      final entities = results.map<CandidateEntity>((data) {
        final CandidateModel model = CandidateModelMapper.ensureInitialized()
            .decodeMap(data);
        return model.toEntity();
      }).toList();
      return Success(entities);
    } on Exception catch (e) {
      return Error(_mapExceptionToFailure(e));
    }
  }

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

  @override
  Future<Result<void, Failure>> removeCandidateBookmark(
    String companyId,
    String candidateId,
  ) async {
    try {
      await remote.removeCandidateBookmark(companyId, candidateId);
      return const Success(null);
    } on Exception catch (e) {
      return Error(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<List<CandidateEntity>, Failure>> getCompanyBookmarks(
    String companyId,
  ) async {
    try {
      final results = await remote.getCompanyBookmarks(companyId);

      final entities = results.map<CandidateEntity>((data) {
        final CandidateModel model = CandidateModelMapper.ensureInitialized()
            .decodeMap(data);
        return model.toEntity();
      }).toList();

      return Success(entities);
    } on Exception catch (e) {
      return Error(_mapExceptionToFailure(e));
    }
  }

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

  @override
  Future<Result<void, Failure>> verifyCompanyQR(String qrCodeData) async {
    try {
      await remote.verifyCompanyQR(qrCodeData);
      return const Success(null);
    } on Exception catch (e) {
      return Error(_mapExceptionToFailure(e));
    }
  }
}
