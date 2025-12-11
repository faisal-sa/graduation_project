import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/individuals/features/skills_languages/domain/entities/user_profile.dart';
import 'package:graduation_project/features/individuals/features/skills_languages/domain/repositories/skills_languages_repository.dart';
import 'package:graduation_project/features/individuals/features/skills_languages/presentation/cubit/skills_languages_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class SkillsLanguagesCubit extends Cubit<SkillsLanguagesState> {
  final SkillsLanguagesRepository _repository;

  SkillsLanguagesCubit(this._repository) : super(SkillsLanguagesInitial());

  Future<void> loadProfile() async {
    emit(SkillsLanguagesLoading());
    final result = await _repository.getData();

    result.fold(
      (failure) => emit(SkillsLanguagesError(failure.message)),
      (profile) => emit(SkillsLanguagesLoaded(profile)),
    );
  }

  // --- ADD METHODS (From your code) ---

  Future<void> addSkill(String newSkill) async {
    if (state is! SkillsLanguagesLoaded) return;
    final currentProfile = (state as SkillsLanguagesLoaded).skillsLanguages;

    // Prevent duplicates
    if (currentProfile.skills.contains(newSkill)) return;

    final updatedSkills = List<String>.from(currentProfile.skills)
      ..add(newSkill);

    emit(
      SkillsLanguagesLoaded(
        SkillsAndLanguages(
          id: currentProfile.id,
          skills: updatedSkills,
          languages: currentProfile.languages,
        ),
      ),
    );

    final result = await _repository.updateSkills(updatedSkills);

    result.fold((failure) {
      emit(SkillsLanguagesError(failure.message));
      emit(SkillsLanguagesLoaded(currentProfile)); // Revert
    }, (_) => null);
  }

  Future<void> addLanguage(String newLanguage) async {
    if (state is! SkillsLanguagesLoaded) return;
    final currentProfile = (state as SkillsLanguagesLoaded).skillsLanguages;

    // Prevent duplicates
    if (currentProfile.languages.contains(newLanguage)) return;

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
      emit(SkillsLanguagesLoaded(currentProfile)); // Revert
    }, (_) => null);
  }

  // --- DELETE METHODS (Implemented) ---

  Future<void> removeSkill(String skillToRemove) async {
    // 1. Check if data is loaded
    if (state is! SkillsLanguagesLoaded) return;

    // 2. Capture current state for potential revert
    final currentProfile = (state as SkillsLanguagesLoaded).skillsLanguages;

    // 3. Create new list excluding the item (Immutability)
    final updatedSkills = List<String>.from(currentProfile.skills)
      ..remove(skillToRemove);

    // 4. Optimistic Update: Update UI immediately
    emit(
      SkillsLanguagesLoaded(
        SkillsAndLanguages(
          id: currentProfile.id,
          skills: updatedSkills,
          languages: currentProfile.languages,
        ),
      ),
    );

    // 5. API Call to Supabase
    final result = await _repository.updateSkills(updatedSkills);

    // 6. Handle Failure
    result.fold(
      (failure) {
        emit(SkillsLanguagesError(failure.message));
        // Revert to original state if API fails
        emit(SkillsLanguagesLoaded(currentProfile)); 
      },
      (_) => null, // Success
    );
  }

  Future<void> removeLanguage(String languageToRemove) async {
    if (state is! SkillsLanguagesLoaded) return;
    
    final currentProfile = (state as SkillsLanguagesLoaded).skillsLanguages;

    final updatedLanguages = List<String>.from(currentProfile.languages)
      ..remove(languageToRemove);

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
