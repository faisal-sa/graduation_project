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
    print("fetching now");
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        print("UserCubit: No logged-in user found.");
        return;
      }


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

      final fetchedUser = _mapSupabaseResponseToEntity(response);
final userMap = fetchedUser.toJson();
      final prettyString = const JsonEncoder.withIndent('  ').convert(userMap);
      print(prettyString);
      
      emit(state.copyWith(user: fetchedUser));
      _saveUserToStorage(fetchedUser);
    } catch (e) {
      print("Error fetching user profile from Supabase: $e");
    }
  }






















  //===========================================================MAPPING LOGIC===========================================================

  Certification _mapSupabaseCertification(Map<String, dynamic> map) {
    return Certification(
      id: map['id']?.toString() ?? '',
      name: map['name'] ?? '',
      // Map DB 'issuing_institution' to Dart 'issuingInstitution'
      issuingInstitution: map['issuing_institution'] ?? '',

      // Handle required Date (Fallback to now if DB is null, though DB allows null)
      issueDate: map['issue_date'] != null
          ? DateTime.parse(map['issue_date'])
          : DateTime.now(),

      // Map DB 'expiration_date'
      expirationDate: map['expiration_date'] != null
          ? DateTime.parse(map['expiration_date'])
          : null,

      // Map DB 'credential_url'
      credentialUrl: map['credential_url'],
    );
  }
  UserEntity _mapSupabaseResponseToEntity(Map<String, dynamic> data) {
    // 1. Map Educations
    final educationList =
        (data['educations'] as List<dynamic>?)
            ?.map((e) => _mapSupabaseEducation(e))
            .toList() ??
        [];

    // 2. Map Work Experiences
    final workList =
        (data['work_experiences'] as List<dynamic>?)
            ?.map((e) => _mapSupabaseWorkExperience(e))
            .toList() ??
        [];

    // 3. Map Certifications
    final certList =
        (data['certifications'] as List<dynamic>?)
            ?.map((e) => _mapSupabaseCertification(e))
            .toList() ??
        [];

    // 4. Map Arrays (Safely handle nulls)
    final List<String> skillsList = data['skills'] != null
        ? List<String>.from(data['skills'])
        : [];

    final List<String> languagesList = data['languages'] != null
        ? List<String>.from(data['languages'])
        : [];

    // =========================================================================
    // 5. MAP JOB PREFERENCES (The Fix)
    // Extract fields from 'profiles' table and put them into JobPreferencesEntity
    // =========================================================================
    final jobPrefs = JobPreferencesEntity(
      targetRoles: data['target_roles'] != null
          ? List<String>.from(data['target_roles'])
          : [],
      employmentTypes: data['employment_types'] != null
          ? List<String>.from(data['employment_types'])
          : [],
      workModes: data['work_modes'] != null
          ? List<String>.from(data['work_modes'])
          : [],
      minSalary: data['min_salary'], // integer
      maxSalary: data['max_salary'], // integer
      salaryCurrency: data['salary_currency'] ?? 'USD',
      canRelocate: data['can_relocate'] ?? false,
      canStartImmediately: data['can_start_immediately'] ?? false,
      noticePeriodDays: data['notice_period_days'], // integer
      // If current_work_status is in your entity, map it too:
      // currentWorkStatus: data['current_work_status'],
    );

    return UserEntity(
      firstName: data['first_name'] ?? '',
      lastName: data['last_name'] ?? '',
      jobTitle: data['job_title'] ?? '',
      phoneNumber: data['phone_number'] ?? '',
      email: data['email'] ?? '',
      location: data['location'] ?? '',
      summary: data['about_me'] ?? '',
      avatarUrl: data['avatar_url'],
      videoUrl: data['intro_video_url'],
      educations: educationList,
      workExperiences: workList,
      certifications: certList,
      skills: skillsList,
      languages: languagesList,
      // Pass the mapped preferences here
      jobPreferences: jobPrefs, 
    );
  }
  /// Helper for WorkExperience (Snake Case DB -> Camel Case Entity)
  WorkExperience _mapSupabaseWorkExperience(Map<String, dynamic> map) {
    return WorkExperience(
      id: map['id']?.toString() ?? '',
      jobTitle: map['job_title'] ?? '',
      companyName: map['company_name'] ?? '',
      employmentType: map['employment_type'] ?? '',
      location: map['location'] ?? '',
      responsibilities: List<String>.from(map['responsibilities'] ?? []),
      startDate: DateTime.parse(map['start_date']),
      endDate: map['end_date'] != null ? DateTime.parse(map['end_date']) : null,
      isCurrentlyWorking: map['is_currently_working'] ?? false,
    );
  }

  /// Helper for Education (Snake Case DB -> Camel Case Entity)
  /// Note: If you use EducationModel.fromJson, ensure it matches DB keys exactly.
  Education _mapSupabaseEducation(Map<String, dynamic> map) {
    return Education(
      id: map['id']?.toString() ?? '',
      degreeType: map['degree_type'] ?? '',
      institutionName: map['institution_name'] ?? '',
      fieldOfStudy: map['field_of_study'] ?? '',
      startDate: DateTime.parse(map['start_date']),
      endDate: DateTime.parse(map['end_date']),
      gpa: map['gpa']?.toString(), // Handle potential numeric types from DB
      activities: List<String>.from(map['activities'] ?? []),
      graduationCertificateUrl: map['graduation_certificate_url'],
      academicRecordUrl: map['academic_record_url'],
    );
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
