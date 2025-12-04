import 'dart:convert';
import 'dart:io';

import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/individuals/features/education/domain/entities/education.dart';
import 'package:graduation_project/features/individuals/features/work_experience/domain/entities/work_experience.dart';
import 'package:graduation_project/features/shared/user_entity.dart';
import 'package:graduation_project/features/shared/user_state.dart';
import 'package:graduation_project/main.dart';
import 'package:injectable/injectable.dart';
import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton()
class UserCubit extends Cubit<UserState> {
  final SharedPreferences _prefs;
  static const String _storageKey = 'user_entity_data';
  UserCubit(this._prefs) : super(const UserState()) {
    _loadUserFromStorage();
  }

  void _loadUserFromStorage() {
    try {
      final jsonString = _prefs.getString(_storageKey);
      if (jsonString != null && jsonString.isNotEmpty) {
        final user = UserEntity.fromJson(jsonString);
        emit(state.copyWith(user: user));
      }
    } catch (e) {
      print("Error loading user from local storage: $e");
    }
  }

  @override
  void onChange(Change<UserState> change) {
    super.onChange(change);
    if (change.nextState.user != change.currentState.user) {
      _saveUserToStorage(change.nextState.user);
    }
  }

  Future<void> _saveUserToStorage(UserEntity user) async {
    try {
      final jsonString = user.toJson();
      await _prefs.setString(_storageKey, jsonString);
    } catch (e) {
      print("Error saving user to local storage: $e");
    }
  }

  void setInitialUserData(UserEntity user) {
    emit(state.copyWith(user: user));
  }

  void updateLocalAvatar(String url) {
    final updatedUser = state.user.copyWith(avatarUrl: url);
    emit(state.copyWith(user: updatedUser));
  }
  // --- Resume Upload Logic  ---

  Future<void> uploadAndExtractResume() async {
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
      print("Raw AI Response: $responseText");
      throw Exception("Failed to parse AI JSON: $e");
    }
  }
  // --- Existing Methods ---

  void updateBasicInfo({
    String? firstName,
    String? lastName,
    String? jobTitle,
    String? phone,
    String? email,
    String? location,
  }) {
    final updatedUser = state.user.copyWith(
      firstName: firstName,
      lastName: lastName,
      jobTitle: jobTitle,
      phoneNumber: phone,
      email: email,
      location: location,
    );
    emit(state.copyWith(user: updatedUser));
  }

  void updateAboutMe({String? summary, String? videoUrl}) {
    final updatedUser = state.user.copyWith(
      summary: summary,
      videoUrl: videoUrl,
    );
    emit(state.copyWith(user: updatedUser));
  }

  void updateUser(UserEntity newUser) {
    emit(state.copyWith(user: newUser));
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
}
