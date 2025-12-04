import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecasesAbstract/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class VerifyOTPParams {
  final String email;
  final String token;

  VerifyOTPParams({required this.email, required this.token});
}

@injectable
class VerifyOTP implements UseCase<User, VerifyOTPParams> {
  final AuthRepository repository;

  VerifyOTP(this.repository);

  @override
  Future<Result<User, Failure>> call(VerifyOTPParams params) {
    return repository.verifyOTP(email: params.email, token: params.token);
  }
}
