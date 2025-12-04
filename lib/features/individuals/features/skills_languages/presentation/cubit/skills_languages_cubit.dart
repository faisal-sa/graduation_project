import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/individuals/features/skills_languages/domain/entities/user_profile.dart';
import 'package:graduation_project/features/individuals/features/skills_languages/domain/repositories/skills_languages_repository.dart';
import 'package:graduation_project/features/individuals/features/skills_languages/presentation/cubit/skills_languages_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class SkillsLanguagesCubit extends Cubit<SkillsLanguagesState> {
  final SkillsLanguagesRepository _repository;

  SkillsLanguagesCubit(this._repository) : super(SkillsLanguagesInitial());

  void removeLanguage(String s) {}
  void removeSkill(String s) {}

  Future<void> loadProfile() async {
    emit(SkillsLanguagesLoading());
    final result = await _repository.getData();

    result.fold(
      (failure) => emit(SkillsLanguagesError(failure.message)),
      (profile) => emit(SkillsLanguagesLoaded(profile)),
    );
  }

  Future<void> addSkill(String newSkill) async {
    if (state is! SkillsLanguagesLoaded) return;
    final currentProfile = (state as SkillsLanguagesLoaded).skillsLanguages;

    // Create new list to ensure immutability
    final updatedSkills = List<String>.from(currentProfile.skills)
      ..add(newSkill);

    // Optimistic Update (update UI immediately)
    emit(
      SkillsLanguagesLoaded(
        SkillsAndLanguages(
          id: currentProfile.id,
          skills: updatedSkills,
          languages: currentProfile.languages,
        ),
      ),
    );

    // API Call
    final result = await _repository.updateSkills(updatedSkills);

    result.fold(
      (failure) {
        // Revert on failure
        emit(SkillsLanguagesError(failure.message));
        emit(SkillsLanguagesLoaded(currentProfile)); // Go back to original
      },
      (_) => null, // Success, UI is already updated
    );
  }

  Future<void> addLanguage(String newLanguage) async {
    if (state is! SkillsLanguagesLoaded) return;
    final currentProfile = (state as SkillsLanguagesLoaded).skillsLanguages;

    final updatedLanguages = List<String>.from(currentProfile.languages)
      ..add(newLanguage);

    emit(
      SkillsLanguagesLoaded(
        SkillsAndLanguages(
          id: currentProfile.id,
          skills: currentProfile.skills,
          languages: updatedLanguages,
        ),
      ),
    );

    final result = await _repository.updateLanguages(updatedLanguages);

    result.fold((failure) {
      emit(SkillsLanguagesError(failure.message));
      emit(SkillsLanguagesLoaded(currentProfile));
    }, (_) => null);
  }
}
