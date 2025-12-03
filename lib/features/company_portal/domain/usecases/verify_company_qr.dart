// lib/features/company_portal/domain/usecases/verify_company_qr.dart
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../../../core/error/failures.dart';
import '../repositories/company_portal_repository.dart';

@injectable
class VerifyCompanyQR {
  final CompanyRepository _repository;

  VerifyCompanyQR(this._repository);

  Future<Result<void, Failure>> call(String qrCodeData) async {
    return await _repository.verifyCompanyQR(qrCodeData);
  }
}
