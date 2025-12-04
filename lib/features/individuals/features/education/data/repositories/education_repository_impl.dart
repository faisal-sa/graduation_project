import 'package:injectable/injectable.dart';
import '../../domain/entities/education.dart';
import '../../domain/repositories/education_repository.dart';
import '../datasources/education_remote_data_source.dart';

@LazySingleton(as: EducationRepository)
class EducationRepositoryImpl implements EducationRepository {
  final EducationRemoteDataSource _remoteDataSource;

  EducationRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<Education>> getEducations() async {
    return await _remoteDataSource.getEducations();
  }

  @override
  Future<void> addEducation(Education education) async {
    await _remoteDataSource.addEducation(education);
  }

  @override
  Future<void> updateEducation(Education education) async {
    await _remoteDataSource.updateEducation(education);
  }

  @override
  Future<void> deleteEducation(String id) async {
    await _remoteDataSource.deleteEducation(id);
  }
}
