import 'package:injectable/injectable.dart';
import '../../domain/entities/cr_info.dart';
import '../../domain/repositories/cr_info_repository.dart';
import '../datasources/wathq_remote_datasource.dart';

@LazySingleton(as: CrInfoRepository)
class CrInfoRepositoryImpl implements CrInfoRepository {
  final WathqRemoteDataSource remoteDataSource;

  CrInfoRepositoryImpl(this.remoteDataSource);

  @override
  Future<CrInfo> getCrInfo(String crNumber) async {
    final model = await remoteDataSource.getCrInfo(crNumber);
    return model.toEntity();
  }
}
