// lib/features/company_portal/domain/usecases/check_company_status.dart

import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../../../core/error/failures.dart';
import '../repositories/company_portal_repository.dart';

@injectable
class CheckCompanyStatus {
  final CompanyRepository repository;

  CheckCompanyStatus(this.repository);

  Future<Result<Map<String, bool>, Failure>> call(String userId) {
    return repository.checkCompanyStatus(userId);
  }
}
