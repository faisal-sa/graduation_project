import 'package:graduation_project/features/company_portal/data/data_sources/company_portal_data_source.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:graduation_project/core/error/failures.dart';
import 'package:graduation_project/features/shared/data/domain/entities/company_entity.dart';
import 'package:graduation_project/features/company_portal/domain/repositories/company_portal_repository.dart';
import 'package:graduation_project/features/shared/data/models/company_model.dart';

Failure _mapExceptionToFailure(Object e) {
  if (e is SupabaseException) {
    if (e.message.contains('not found') || e.message.contains('null')) {
      return NotFoundFailure('لم يتم العثور على البيانات المطلوبة');
    }
    if (e.message.contains('duplicate')) {
      return InvalidInputFailure('هذه البيانات مسجلة مسبقاً');
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
    };
  }

  @override
  Future<Result<CompanyEntity, Failure>> registerCompany({
    required String email,
    required String password,
  }) async {
    try {
      final data = await remote.registerCompany(email, password);

      final model = CompanyModelMapper.fromMap(data);

      return Success(model.toEntity());
    } catch (e) {
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
        return Success(_getEmptyCompany());
      }

      try {
        final model = CompanyModelMapper.fromMap(data);
        return Success(model.toEntity());
      } catch (mappingError) {
        print(
          "⚠️ Mapping Error (Returning empty to prevent crash): $mappingError",
        );
        return Success(_getEmptyCompany());
      }
    } catch (e, s) {
      return Success(_getEmptyCompany());
    }
  }

  @override
  Future<Result<CompanyEntity, Failure>> updateCompanyProfile(
    CompanyEntity company,
  ) async {
    try {
      final updatePayload = _entityToMap(company);
      final updatedData = await remote.updateCompanyProfile(updatePayload);

      final updatedModel = CompanyModelMapper.fromMap(updatedData);

      return Success(updatedModel.toEntity());
    } catch (e) {
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
    } catch (e) {
      return Error(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<void, Failure>> verifyCompanyQR(String qrCodeData) async {
    try {
      await remote.verifyCompanyQR(qrCodeData);
      return const Success(null);
    } catch (e) {
      return Error(_mapExceptionToFailure(e));
    }
  }

  // دالة مساعدة لإنشاء شركة فارغة
  CompanyEntity _getEmptyCompany() {
    return CompanyEntity(
      companyName: '',
      industry: '',
      description: '',
      city: '',
      address: '',
      website: '',
      email: '',
      phone: '',
      logoUrl: '',
      companySize: '1-50 employees',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}
