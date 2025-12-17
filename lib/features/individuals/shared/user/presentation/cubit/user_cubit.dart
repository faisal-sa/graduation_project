import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/individuals/profile/routes/certifications/domain/entities/certification.dart';
import 'package:graduation_project/features/individuals/profile/routes/education/domain/entities/education.dart';
import 'package:graduation_project/features/individuals/profile/routes/job_preferences/domain/entities/job_preferences_entity.dart';
import 'package:graduation_project/features/individuals/profile/routes/work_experience/domain/entities/work_experience.dart';
import 'package:graduation_project/features/individuals/shared/user/domain/entities/user_entity.dart';
import 'package:graduation_project/features/individuals/shared/user/domain/usecases/cache_user.dart';
import 'package:graduation_project/features/individuals/shared/user/domain/usecases/fetch_user_profile.dart';
import 'package:graduation_project/features/individuals/shared/user/domain/usecases/get_cached_user.dart';
import 'package:graduation_project/features/individuals/shared/user/domain/usecases/parse_resume_with_ai.dart';
import 'package:graduation_project/features/individuals/shared/user/domain/usecases/update_user.dart';
import 'package:graduation_project/features/individuals/shared/user/presentation/cubit/user_state.dart';
import 'package:injectable/injectable.dart';
import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@lazySingleton
class UserCubit extends Cubit<UserState> {
  final GetCachedUser _getCachedUser;
  final CacheUser _cacheUser;
  final FetchUserProfile _fetchUserProfile;
  final ParseResumeWithAI _parseResumeWithAI;
  final UpdateUser _updateUser;
  
  final SupabaseClient _supabaseClient; 
  bool _isLoadingFromStorage = false;


  UserCubit(
    this._getCachedUser,
    this._cacheUser,
    this._fetchUserProfile,
    this._parseResumeWithAI,
    this._supabaseClient,
    this._updateUser
  ) : super(const UserState()) {
    _loadUserFromStorage();
  }

  
 Future<void> _loadUserFromStorage() async {
    debugPrint("loading user from storage");
    _isLoadingFromStorage = true; 

    try {
      final user = await _getCachedUser();
      if (user != null) {
        emit(state.copyWith(user: user));
      }
    } catch (e) {
      debugPrint("Error loading local user: $e");
    } finally {
      _isLoadingFromStorage = false; 
    }
  }

  @override
  void onChange(Change<UserState> change) {
    super.onChange(change);

    if (_isLoadingFromStorage) {
      debugPrint("UserCubit: Loaded from storage (Skipping auto-save)");
      return;
    }

    if (change.nextState.user != change.currentState.user) {
      debugPrint("UserCubit: User entity changed, saving to storage...");
      _cacheUser(change.nextState.user);
    }
  }


  void setInitialUserData(UserEntity user) {
    emit(state.copyWith(user: user));
  }

  
  void updateLocalAvatar(String url) {
    emit(state.copyWith(user: state.user.copyWith(avatarUrl: url)));
  }

  void updateSkillsAndLanguages(List<String> skills, List<String> languages) {
    emit(state.copyWith(
      user: state.user.copyWith(skills: skills, languages: languages),
    ));
  }

  void updateJobPreferences(JobPreferencesEntity newPreferences) {
    emit(state.copyWith(
      user: state.user.copyWith(jobPreferences: newPreferences),
    ));
  }

  void updateCertificationsList(List<Certification> certifications) {
    emit(state.copyWith(user: state.user.copyWith(certifications: certifications)));
  }

  void updateBasicInfo({
    String? firstName,
    String? lastName,
    String? jobTitle,
    String? phone,
    String? email,
    String? location,
  }) {
    final updatedUser = state.user.copyWith(
      firstName: firstName ?? state.user.firstName,
      lastName: lastName ?? state.user.lastName,
      jobTitle: jobTitle ?? state.user.jobTitle,
      phoneNumber: phone ?? state.user.phoneNumber,
      email: email ?? state.user.email,
      location: location ?? state.user.location,
    );
    emit(state.copyWith(user: updatedUser));
  }

  void updateAboutMe({String? summary, String? videoUrl}) {
    final u = state.user;


    final explicitUser = UserEntity(
      firstName: u.firstName,
      lastName: u.lastName,
      jobTitle: u.jobTitle,
      phoneNumber: u.phoneNumber,
      email: u.email,
      location: u.location,
      avatarUrl: u.avatarUrl,
      workExperiences: u.workExperiences,
      educations: u.educations,
      certifications: u.certifications,
      skills: u.skills,
      languages: u.languages,
      jobPreferences: u.jobPreferences,
      summary: summary ?? u.summary,
      videoUrl: videoUrl, 
    );

    emit(state.copyWith(user: explicitUser));
  }

  void deleteUserVideo() {
    debugPrint("UserCubit: Deleting user video...");
    final u = state.user;
    
    final updatedUser = UserEntity(
      firstName: u.firstName,
      lastName: u.lastName,
      jobTitle: u.jobTitle,
      phoneNumber: u.phoneNumber,
      email: u.email,
      location: u.location,
      summary: u.summary,
      avatarUrl: u.avatarUrl,
      workExperiences: u.workExperiences,
      educations: u.educations,
      certifications: u.certifications,
      skills: u.skills,
      languages: u.languages,
      jobPreferences: u.jobPreferences,
      videoUrl: null, 
    );

    emit(state.copyWith(user: updatedUser));
  }

  void updateUser(UserEntity newUser) {
    emit(state.copyWith(user: newUser));
  }

  
  void updateWorkExperiencesList(List<WorkExperience> experiences) {
    final sortedList = List<WorkExperience>.from(experiences)
      ..sort((a, b) => b.startDate.compareTo(a.startDate));
    emit(state.copyWith(user: state.user.copyWith(workExperiences: sortedList)));
  }

  void updateEducationsList(List<Education> educations) {
    final sortedList = List<Education>.from(educations)
      ..sort((a, b) => b.startDate.compareTo(a.startDate));
    emit(state.copyWith(user: state.user.copyWith(educations: sortedList)));
  }

  void addWorkExperience(WorkExperience experience) {
    final currentList = List<WorkExperience>.from(state.user.workExperiences);
    currentList.add(experience);
    currentList.sort((a, b) => b.startDate.compareTo(a.startDate));
    emit(state.copyWith(user: state.user.copyWith(workExperiences: currentList)));
  }

  void removeWorkExperience(String id) {
    final currentList = List<WorkExperience>.from(state.user.workExperiences);
    currentList.removeWhere((element) => element.id == id);
    emit(state.copyWith(user: state.user.copyWith(workExperiences: currentList)));
  }

  void addEducation(Education education) {
    final currentList = List<Education>.from(state.user.educations);
    currentList.add(education);
    currentList.sort((a, b) => b.startDate.compareTo(a.startDate));
    emit(state.copyWith(user: state.user.copyWith(educations: currentList)));
  }

  void removeEducation(String id) {
    final currentList = List<Education>.from(state.user.educations);
    currentList.removeWhere((element) => element.id == id);
    emit(state.copyWith(user: state.user.copyWith(educations: currentList)));
  }

  
  Future<void> fetchUserProfile() async {
    try {
      final userId = _supabaseClient.auth.currentUser?.id;
      if (userId == null) return;

      final fetchedUser = await _fetchUserProfile(userId);

      emit(state.copyWith(user: fetchedUser));

    } catch (e) {
      debugPrint("Error fetching user profile: $e");
    }
  }

  
 Future<void> uploadAndExtractResume() async {
    try {
      emit(state.copyWith(isResumeLoading: true, resumeError: null));

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        withData: true,
      );

      if (result == null) {
        emit(state.copyWith(isResumeLoading: false));
        return;
      }

      final platformFile = result.files.single;
      Uint8List? fileBytes;

      if (platformFile.bytes != null) {
        fileBytes = platformFile.bytes;
      } else if (platformFile.path != null && !kIsWeb) {
        final file = File(platformFile.path!);
        fileBytes = await file.readAsBytes();
      }

      if (fileBytes == null) {
        emit(state.copyWith(isResumeLoading: false));
        return;
      }

      final extractedUser = await _parseResumeWithAI(fileBytes);

      final updatedUser = state.user.copyWith(
        firstName: extractedUser.firstName.isNotEmpty ? extractedUser.firstName : state.user.firstName,
        lastName: extractedUser.lastName.isNotEmpty ? extractedUser.lastName : state.user.lastName,
        email: extractedUser.email.isNotEmpty ? extractedUser.email : state.user.email,
        phoneNumber: extractedUser.phoneNumber.isNotEmpty ? extractedUser.phoneNumber : state.user.phoneNumber,
        jobTitle: extractedUser.jobTitle.isNotEmpty ? extractedUser.jobTitle : state.user.jobTitle,
        location: extractedUser.location.isNotEmpty ? extractedUser.location : state.user.location,
        summary: extractedUser.summary.isNotEmpty ? extractedUser.summary : state.user.summary,
        
        workExperiences: [...state.user.workExperiences, ...extractedUser.workExperiences],
        educations: [...state.user.educations, ...extractedUser.educations],
        certifications: [...state.user.certifications, ...extractedUser.certifications],
        
        skills: {...state.user.skills, ...extractedUser.skills}.toList(),
        languages: {...state.user.languages, ...extractedUser.languages}.toList(),
      );

      emit(state.copyWith(user: updatedUser, isResumeLoading: false));
      
      debugPrint("Auto-saving extracted resume data to Supabase...");
      await _updateUser(updatedUser);
      debugPrint("Supabase update complete.");
      
    } catch (e) {
      debugPrint("Resume upload error: $e");
      emit(state.copyWith(
        isResumeLoading: false,
        resumeError: 'Failed to process resume: $e',
      ));
    }
  }
}