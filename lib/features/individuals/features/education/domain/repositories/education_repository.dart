import '../entities/education.dart';

abstract class EducationRepository {
  Future<List<Education>> getEducations();
  Future<void> addEducation(Education education);
  Future<void> updateEducation(Education education);
  Future<void> deleteEducation(String id);
}
