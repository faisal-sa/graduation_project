import 'package:graduation_project/features/individuals/features/basic_info/data/datasources/basic_info_remote_data_source.dart';
import 'package:graduation_project/features/individuals/features/basic_info/data/models/basic_info_model.dart';
import 'package:graduation_project/features/individuals/features/basic_info/domain/entities/basic_info_entity.dart';
import 'package:graduation_project/features/individuals/features/basic_info/domain/repositories/basic_info_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: BasicInfoRepository)
class BasicInfoRepositoryImpl implements BasicInfoRepository {
  final BasicInfoRemoteDataSource _remoteDataSource;

  BasicInfoRepositoryImpl(this._remoteDataSource);

  @override
  Future<void> saveBasicInfo(BasicInfoEntity basicInfo) async {
    try {
      final model = BasicInfoModel.fromEntity(basicInfo);
      await _remoteDataSource.saveBasicInfo(model);
    } catch (e) {
      throw Exception("Repository Error: $e");
    }
  }
}
