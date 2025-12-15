// lib/features/candidate_details/data/models/candidate_profile_model.dart

import 'package:dart_mappable/dart_mappable.dart';
import '../../domain/entities/candidate_profile_entity.dart';
import 'work_experience_model.dart';
import 'education_model.dart';
import 'certification_model.dart';

part 'candidate_profile_model.mapper.dart';

@MappableClass(
  caseStyle: CaseStyle.snakeCase,
  generateMethods:
      GenerateMethods.decode |
      GenerateMethods.encode |
      GenerateMethods.stringify,
)
class CandidateProfileModel extends CandidateProfileEntity {
  @override
  @MappableField(key: 'work_experiences')
  final List<WorkExperienceModel> experiences;

  @override
  @MappableField(key: 'educations')
  final List<EducationModel> educations;

  @override
  @MappableField(key: 'certifications')
  final List<CertificationModel> certifications;

  const CandidateProfileModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.jobTitle,
    super.aboutMe,
    super.avatarUrl,
    super.location,
    super.introVideoUrl,

    // ✅ 1. إضافة تمرير cvUrl هنا
    super.cvUrl,

    super.employmentTypes = const [],
    required super.skills,
    super.canRelocate = false,
    super.canStartImmediately = false,
    super.languages = const [],
    super.targetRoles = const [],
    super.minSalary,
    super.maxSalary,
    super.salaryCurrency,
    super.currentWorkStatus,
    super.noticePeriodDays,
    super.workModes = const [],
    super.email,
    super.phoneNumber,
    required this.experiences,
    required this.educations,
    required this.certifications,
    required super.isUnlocked,
    super.isBookmarked = false,
  }) : super(
         experiences: experiences,
         educations: educations,
         certifications: certifications,
       );

  static CandidateProfileModel fromSupabase(
    Map<String, dynamic> json,
    bool isUnlocked,
    bool isBookmarked,
  ) {
    final sensitiveJson = Map<String, dynamic>.from(json);

    if (sensitiveJson['first_name'] == null) {
      sensitiveJson['first_name'] = "Unknown";
    }
    if (sensitiveJson['last_name'] == null) sensitiveJson['last_name'] = "";
    if (sensitiveJson['job_title'] == null) {
      sensitiveJson['job_title'] = "Open to Work";
    }

    if (!isUnlocked) {
      sensitiveJson['email'] = null;
      sensitiveJson['phone_number'] = null;
      sensitiveJson['cv_url'] = null;
    }

    if (sensitiveJson['work_experiences'] == null) {
      sensitiveJson['work_experiences'] = [];
    }
    if (sensitiveJson['educations'] == null) sensitiveJson['educations'] = [];
    if (sensitiveJson['certifications'] == null) {
      sensitiveJson['certifications'] = [];
    }
    if (sensitiveJson['employment_types'] == null) {
      sensitiveJson['employment_types'] = [];
    }
    if (sensitiveJson['skills'] == null) sensitiveJson['skills'] = [];
    if (sensitiveJson['languages'] == null) sensitiveJson['languages'] = [];
    if (sensitiveJson['target_roles'] == null) {
      sensitiveJson['target_roles'] = [];
    }
    if (sensitiveJson['work_modes'] == null) sensitiveJson['work_modes'] = [];

    sensitiveJson['is_unlocked'] = isUnlocked;
    sensitiveJson['is_bookmarked'] = isBookmarked;

    return CandidateProfileModelMapper.fromMap(sensitiveJson);
  }
}
