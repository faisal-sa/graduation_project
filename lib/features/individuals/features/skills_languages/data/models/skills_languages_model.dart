import 'package:graduation_project/features/individuals/features/skills_languages/domain/entities/user_profile.dart';

class SkillsAndLanguagesModel extends SkillsAndLanguages {
  SkillsAndLanguagesModel({
    required super.id,
    required super.skills,
    required super.languages,
  });

  factory SkillsAndLanguagesModel.fromJson(Map<String, dynamic> json) {
    return SkillsAndLanguagesModel(
      id: json['id'] as String,
      // Handle nulls and convert dynamic list to String list
      skills:
          (json['skills'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      languages:
          (json['languages'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'skills': skills, 'languages': languages};
  }
}
