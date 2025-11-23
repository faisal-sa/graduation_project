import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecasesAbstract/usecase.dart';
import '../../../../core/usecasesAbstract/no_params.dart';
import '../repositories/auth_repository.dart';

@injectable
class SignOut implements UseCase<void, NoParams> {
  final AuthRepository repository;

  SignOut(this.repository);

  @override
  Future<Result<void, Failure>> call(NoParams params) {
    return repository.signOut();
  }
}
