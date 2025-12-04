import '../../domain/entities/work_experience.dart';

class WorkExperienceModel extends WorkExperience {
  const WorkExperienceModel({
    required super.id,
    required super.jobTitle,
    required super.companyName,
    required super.employmentType,
    required super.location,
    required super.responsibilities,
    required super.startDate,
    super.endDate,
    super.isCurrentlyWorking,
  });

  factory WorkExperienceModel.fromJson(Map<String, dynamic> json) {
    return WorkExperienceModel(
      id: json['id'] as String,
      jobTitle: json['job_title'] as String,
      companyName: json['company_name'] as String,
      employmentType: json['employment_type'] as String,
      location: json['location'] as String,
      responsibilities: List<String>.from(json['responsibilities'] ?? []),
      startDate: DateTime.parse(json['start_date']),
      endDate: json['end_date'] != null
          ? DateTime.parse(json['end_date'])
          : null,
      isCurrentlyWorking: json['is_currently_working'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson({required String userId}) {
    return {
      'id': id,
      'user_id': userId,
      'job_title': jobTitle,
      'company_name': companyName,
      'employment_type': employmentType,
      'location': location,
      'responsibilities': responsibilities,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'is_currently_working': isCurrentlyWorking,
    };
  }

  factory WorkExperienceModel.fromEntity(WorkExperience entity) {
    return WorkExperienceModel(
      id: entity.id,
      jobTitle: entity.jobTitle,
      companyName: entity.companyName,
      employmentType: entity.employmentType,
      location: entity.location,
      responsibilities: entity.responsibilities,
      startDate: entity.startDate,
      endDate: entity.endDate,
      isCurrentlyWorking: entity.isCurrentlyWorking,
    );
  }
}
