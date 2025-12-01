// lib/features/company_portal/domain/usecases/update_company_profile.dart

import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../../../core/error/failures.dart';
import '../entities/company_entity.dart';
import '../repositories/company_portal_repository.dart';

@injectable
class UpdateCompanyProfile {
  final CompanyRepository repository;

  UpdateCompanyProfile(this.repository);

  Future<Result<CompanyEntity, Failure>> call(CompanyEntity company) {
    return repository.updateCompanyProfile(company);
  }
}
