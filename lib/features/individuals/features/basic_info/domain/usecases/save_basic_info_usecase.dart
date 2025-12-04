import 'package:graduation_project/features/individuals/features/basic_info/domain/repositories/basic_info_repository.dart';
import 'package:graduation_project/features/individuals/features/basic_info/domain/entities/basic_info_entity.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SaveBasicInfoUseCase {
  final BasicInfoRepository _repository;

  SaveBasicInfoUseCase(this._repository);

  Future<void> call(BasicInfoEntity basicInfo) async {
    return _repository.saveBasicInfo(basicInfo);
  }
}
