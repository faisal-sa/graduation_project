import 'package:equatable/equatable.dart';
import 'package:graduation_project/features/individuals/features/skills_languages/domain/entities/user_profile.dart';

abstract class SkillsLanguagesState extends Equatable {
  const SkillsLanguagesState();

  @override
  List<Object?> get props => [];
}

class SkillsLanguagesInitial extends SkillsLanguagesState {}

class SkillsLanguagesLoading extends SkillsLanguagesState {}

class SkillsLanguagesLoaded extends SkillsLanguagesState {
  final SkillsAndLanguages skillsLanguages;
  const SkillsLanguagesLoaded(this.skillsLanguages);

  @override
  List<Object?> get props => [skillsLanguages];
}

class SkillsLanguagesError extends SkillsLanguagesState {
  final String message;
  const SkillsLanguagesError(this.message);

  @override
  List<Object?> get props => [message];
}
