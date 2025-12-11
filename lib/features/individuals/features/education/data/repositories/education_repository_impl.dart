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
    try {
      final models = await _remoteDataSource.getEducations();

      // FIX: Map the models to entities
      return models.map((model) => model.toEntity()).toList();
    } catch (e) {
      // It is good practice to handle errors here as well, similar to above
      throw Exception('Failed to fetch educations: $e');
    }
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
