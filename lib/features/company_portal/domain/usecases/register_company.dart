// lib/features/company_portal/domain/usecases/register_company.dart
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../../../core/error/failures.dart';
import '../entities/company_entity.dart';
import '../repositories/company_portal_repository.dart';

@injectable
class RegisterCompany {
  final CompanyRepository _repository;

  RegisterCompany(this._repository);

  Future<Result<CompanyEntity, Failure>> call({
    required String email,
    required String password,
  }) async {
    return await _repository.registerCompany(email: email, password: password);
  }
}
