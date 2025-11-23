import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecasesAbstract/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class SignInParams {
  final String email;
  final String password;

  SignInParams({required this.email, required this.password});
}

@injectable
class SignIn implements UseCase<User, SignInParams> {
  final AuthRepository repository;

  SignIn(this.repository);

  @override
  Future<Result<User, Failure>> call(SignInParams params) {
    return repository.signIn(email: params.email, password: params.password);
  }
}
