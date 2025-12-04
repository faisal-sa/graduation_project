import 'package:injectable/injectable.dart';
import '../entities/cr_info.dart';
import '../repositories/cr_info_repository.dart';

@injectable
class GetCrInfo {
  final CrInfoRepository repository;

  GetCrInfo(this.repository);

  Future<CrInfo> call(String crNumber) {
    return repository.getCrInfo(crNumber);
  }
}
