import 'package:graduation_project/features/individuals/features/work_experience/domain/repositories/work_experience_repository.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/work_experience.dart';
import '../datasources/work_experience_remote_data_source.dart';
import '../models/work_experience_model.dart';

@LazySingleton(as: WorkExperienceRepository)
class WorkExperienceRepositoryImpl implements WorkExperienceRepository {
  final WorkExperienceRemoteDataSource _remoteDataSource;

  WorkExperienceRepositoryImpl(this._remoteDataSource);

  @override
  Future<void> addWorkExperience(WorkExperience experience) async {
    final model = WorkExperienceModel.fromEntity(experience);
    await _remoteDataSource.addWorkExperience(model);
  }

  @override
  Future<void> updateWorkExperience(WorkExperience experience) async {
    final model = WorkExperienceModel.fromEntity(experience);
    await _remoteDataSource.updateWorkExperience(model);
  }

  @override
  Future<void> deleteWorkExperience(String id) async {
    await _remoteDataSource.deleteWorkExperience(id);
  }

  @override
  Future<List<WorkExperience>> getWorkExperiences() async {
    final models = await _remoteDataSource.getWorkExperiences();
    return models;
  }
}
