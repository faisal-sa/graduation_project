import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/work_experience.dart';


part 'work_experience_model.freezed.dart';
part 'work_experience_model.g.dart';

@freezed
abstract class WorkExperienceModel with _$WorkExperienceModel {
  const WorkExperienceModel._(); // Required for custom methods

  // @JsonSerializable(fieldRename: FieldRename.snake) // Optional: saves typing @JsonKey names manually
  const factory WorkExperienceModel({
    required String id,
    @JsonKey(name: 'job_title') required String jobTitle,
    @JsonKey(name: 'company_name') required String companyName,
    @JsonKey(name: 'employment_type') required String employmentType,
    required String location,
    @Default([]) List<String> responsibilities,

    @JsonKey(name: 'start_date') required DateTime startDate,
    @JsonKey(name: 'end_date') DateTime? endDate,

    @JsonKey(name: 'is_currently_working', defaultValue: false)
    required bool isCurrentlyWorking,
  }) = _WorkExperienceModel;

  factory WorkExperienceModel.fromJson(Map<String, dynamic> json) =>
      _$WorkExperienceModelFromJson(json);

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

  WorkExperience toEntity() {
    return WorkExperience(
      id: id,
      jobTitle: jobTitle,
      companyName: companyName,
      employmentType: employmentType,
      location: location,
      responsibilities: responsibilities,
      startDate: startDate,
      endDate: endDate,
      isCurrentlyWorking: isCurrentlyWorking,
    );
  }

  // Custom method to match your original toJson({userId}) logic
  Map<String, dynamic> toApiJson({required String userId}) {
    // Generate the standard JSON
    final json = toJson();
    // Inject the user_id
    json['user_id'] = userId;
    return json;
  }
}
