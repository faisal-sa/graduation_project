import 'dart:convert';
import 'dart:io';

import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/individuals/features/certifications/domain/entities/certification.dart';
import 'package:graduation_project/features/individuals/features/education/domain/entities/education.dart';
import 'package:graduation_project/features/individuals/features/job_preferences/domain/entities/job_preferences_entity.dart';
import 'package:graduation_project/features/individuals/features/work_experience/domain/entities/work_experience.dart';
import 'package:graduation_project/features/shared/user_entity.dart';
import 'package:graduation_project/features/shared/user_state.dart';
import 'package:graduation_project/main.dart';
import 'package:injectable/injectable.dart';
import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton()
class UserCubit extends Cubit<UserState> {
  final SharedPreferences _prefs;
  final SupabaseClient _supabase;
  static const String _storageKey = 'user_entity_data';
  UserCubit(this._prefs, this._supabase) : super(const UserState()) {
    loadUserFromStorage();
  }








//=========================================================== LOCAL STORAGE LOGIC ===========================================================
  void loadUserFromStorage() {
    print("loading user from storage");
    try {
      final jsonString = _prefs.getString(_storageKey);
      if (jsonString != null && jsonString.isNotEmpty) {
        final Map<String, dynamic> userMap = jsonDecode(jsonString);
        final prettyString = const JsonEncoder.withIndent(
          '  ',
        ).convert(userMap);
        print(prettyString);

        final user = UserEntity.fromJson(userMap);
        emit(state.copyWith(user: user));
      }
    } catch (e) {
    }
  }

  Future<void> _saveUserToStorage(UserEntity user) async {
    print("saving now");
    try {
      final jsonString = user.toJson();
      await _prefs.setString(_storageKey, jsonString.toString());
    } catch (e) {
    }
  }

  // Debugging the Change
  @override
  void onChange(Change<UserState> change) {
    super.onChange(change);

    if (change.nextState.user != change.currentState.user) {
      print("UserCubit: User entity changed, saving to storage...");
      _saveUserToStorage(change.nextState.user);
    }
  }

  void setInitialUserData(UserEntity user) {
    emit(state.copyWith(user: user));
  }















































// =========================================================== CHANGING STATE LOGIC ===========================================================

  void updateLocalAvatar(String url) {
    final updatedUser = state.user.copyWith(avatarUrl: url);
    emit(state.copyWith(user: updatedUser));
  }

  void updateSkillsAndLanguages(List<String> skills, List<String> languages) {
    // Create a copy of the current user with updated lists
    final updatedUser = state.user.copyWith(
      skills: skills,
      languages: languages,
    );

    // Emit new state (triggers onChange -> saves to Local Storage)
    emit(state.copyWith(user: updatedUser));
  }


  void updateJobPreferences(JobPreferencesEntity newPreferences) {
    final updatedUser = state.user.copyWith(jobPreferences: newPreferences);

    // Emit new state (this updates local storage if you use HydratedBloc)
    emit(state.copyWith(user: updatedUser));
  }

void updateCertificationsList(List<Certification> certifications) {
    // Create a copy of the current user with the updated certifications list
    final updatedUser = state.user.copyWith(certifications: certifications);

    // Emit the new state (this triggers onChange, which saves to SharedPreferences)
    emit(state.copyWith(user: updatedUser));
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

    // We DO NOT use copyWith here because copyWith ignores nulls.
    // We want to allow 'videoUrl' to be null if the user deleted it.
    final updatedUser = UserEntity(
      // Keep these fields the same
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

      // UPDATE these fields explicitly
      // If summary is passed, use it; otherwise keep old.
      summary: summary ?? u.summary,

      // DIRECTLY ASSIGN videoUrl.
      // If videoUrl is passed as null (deleted), this sets it to null.
      videoUrl: videoUrl,
    );

    emit(state.copyWith(user: updatedUser));
  }

  // Also ensure you have this specific delete helper (from the previous step)
  // for immediate deletion without waiting for the Save button
  void deleteUserVideo() {
    print("UserCubit: Deleting user video..."); // Debug log

    // 1. Create the update explicitly
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
      videoUrl: null, // Force NULL
    );

    // 2. Emit new state
    emit(state.copyWith(user: updatedUser));

    // 3. Force save immediately (Optional: safeguards against onChange failing)
    _saveUserToStorage(updatedUser);
  }

  void updateUser(UserEntity newUser) {
    emit(state.copyWith(user: newUser));
  }

  void updateWorkExperiencesList(List<WorkExperience> experiences) {
    final sortedList = List<WorkExperience>.from(experiences)
      ..sort((a, b) => b.startDate.compareTo(a.startDate));

    emit(
      state.copyWith(user: state.user.copyWith(workExperiences: sortedList)),
    );
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
    emit(
      state.copyWith(user: state.user.copyWith(workExperiences: currentList)),
    );
  }

  void removeWorkExperience(String id) {
    final currentList = List<WorkExperience>.from(state.user.workExperiences);
    currentList.removeWhere((element) => element.id == id);
    emit(
      state.copyWith(user: state.user.copyWith(workExperiences: currentList)),
    );
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

  // =========================================================== SUPABASE FETCHING LOGIC ===========================================================
  Future<void> fetchUserProfile() async {
    await _handleFetchUserProfile();
  }

  Future<void> _handleFetchUserProfile() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return;

      final response = await _supabase
          .from('profiles')
          .select('''
          *,
          educations (*),
          work_experiences (*),
          certifications (*)    
        ''')
          .eq('id', userId)
          .single();

      // 
      // DIRECT MAPPING - No manual intervention needed
      final fetchedUser = UserEntity.fromJson(response);

      emit(state.copyWith(user: fetchedUser));
      _saveUserToStorage(fetchedUser); 
      
    } catch (e) {
      print("Error fetching user profile: $e");
    }
  }




























//=========================================================== CV ANALYSIS LOGIC ============================================================
  Future<void> uploadAndExtractResume() async {
    await _handleResumeUploadAndExtraction();
  }

  Future<UserEntity> _extractDataWithGemini(Uint8List pdfBytes) async {
    final promptText = """
      You are a data extraction assistant.
      Analyze the attached resume PDF.
      Extract the following fields and return them in a raw JSON format:
      - firstName
      - lastName
      - email
      - phoneNumber
      - summary (Create a short professional summary if one doesn't exist)

      Rules:
      1. Return ONLY the JSON object. Do not include markdown formatting like ```json ... ```.
      2. If a field is not found, use an empty string "".
      3. Fix any capitalization issues in names.
    """;

    final prompt = TextPart(promptText);

    final pdfPart = InlineDataPart('application/pdf', pdfBytes);

    final response = await model.generateContent([
      Content.multi([prompt, pdfPart]),
    ]);

    final responseText = response.text;
    debugPrint("AI response to Resume upload:\n $responseText");
    if (responseText == null || responseText.isEmpty) {
      throw Exception("AI returned empty response");
    }

    try {
      String cleanJson = responseText
          .replaceAll('```json', '')
          .replaceAll('```', '')
          .trim();

      final Map<String, dynamic> data = jsonDecode(cleanJson);

      return UserEntity(
        firstName: data['firstName'] ?? '',
        lastName: data['lastName'] ?? '',
        email: data['email'] ?? '',
        phoneNumber: data['phoneNumber'] ?? '',
        summary: data['summary'] ?? '',
      );
    } catch (e) {
      throw Exception("Failed to parse AI JSON: $e");
    }
  }
  Future<void> _handleResumeUploadAndExtraction() async {
    try {
      emit(state.copyWith(isResumeLoading: true, resumeError: null));

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        withData: true,
      );

      if (result != null) {
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

        final extractedUser = await _extractDataWithGemini(fileBytes);

        final updatedUser = state.user.copyWith(
          firstName: extractedUser.firstName.isNotEmpty
              ? extractedUser.firstName
              : state.user.firstName,
          lastName: extractedUser.lastName.isNotEmpty
              ? extractedUser.lastName
              : state.user.lastName,
          email: extractedUser.email.isNotEmpty
              ? extractedUser.email
              : state.user.email,
          phoneNumber: extractedUser.phoneNumber.isNotEmpty
              ? extractedUser.phoneNumber
              : state.user.phoneNumber,
          summary: extractedUser.summary.isNotEmpty
              ? extractedUser.summary
              : state.user.summary,
        );

        emit(state.copyWith(user: updatedUser, isResumeLoading: false));
      } else {
        emit(state.copyWith(isResumeLoading: false));
      }
    } catch (e) {
      emit(
        state.copyWith(
          isResumeLoading: false,
          resumeError: 'Failed to process resume: $e',
        ),
      );
    }
  }







}
