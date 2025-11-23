import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecasesAbstract/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class SignUpParams {
  final String email;
  final String password;

  SignUpParams({required this.email, required this.password});
}

@injectable
class SignUp implements UseCase<User, SignUpParams> {
  final AuthRepository repository;

  SignUp(this.repository);

  @override
  Future<Result<User, Failure>> call(SignUpParams params) {
    return repository.signUp(email: params.email, password: params.password);
  }
}
