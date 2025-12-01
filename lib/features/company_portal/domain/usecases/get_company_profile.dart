// lib/features/company_portal/domain/usecases/get_company_profile.dart

import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../../../core/error/failures.dart';
import '../entities/company_entity.dart';
import '../repositories/company_portal_repository.dart';

@injectable
class GetCompanyProfile {
  final CompanyRepository repository;

  GetCompanyProfile(this.repository);

  Future<Result<CompanyEntity, Failure>> call(String userId) {
    return repository.getCompanyProfile(userId);
  }
}
