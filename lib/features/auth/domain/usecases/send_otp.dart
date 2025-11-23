import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecasesAbstract/usecase.dart';
import '../repositories/auth_repository.dart';

class SendOTPParams {
  final String email;

  SendOTPParams({required this.email});
}

@injectable
class SendOTP implements UseCase<void, SendOTPParams> {
  final AuthRepository repository;

  SendOTP(this.repository);

  @override
  Future<Result<void, Failure>> call(SendOTPParams params) {
    return repository.sendOTP(email: params.email);
  }
}
