import '../entities/cr_info.dart';

abstract class CrInfoRepository {
  Future<CrInfo> getCrInfo(String crNumber);
}

