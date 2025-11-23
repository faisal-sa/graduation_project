import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecasesAbstract/usecase.dart';
import '../repositories/auth_repository.dart';

class ResendOTPParams {
  final String email;

  ResendOTPParams({required this.email});
}

@injectable
class ResendOTP implements UseCase<void, ResendOTPParams> {
  final AuthRepository repository;

  ResendOTP(this.repository);

  @override
  Future<Result<void, Failure>> call(ResendOTPParams params) {
    return repository.resendOTP(email: params.email);
  }
}
