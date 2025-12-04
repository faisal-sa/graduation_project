import 'package:graduation_project/features/individuals/features/basic_info/domain/entities/basic_info_entity.dart';

abstract class BasicInfoRepository {
  Future<void> saveBasicInfo(BasicInfoEntity basicInfo);
}
