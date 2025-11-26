import '../entities/work_experience.dart';

abstract class WorkExperienceRepository {
  Future<void> addWorkExperience(WorkExperience experience);
  Future<void> updateWorkExperience(WorkExperience experience);
  Future<void> deleteWorkExperience(String id);
  Future<List<WorkExperience>> getWorkExperiences();
}
