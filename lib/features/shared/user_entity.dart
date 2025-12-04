import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:graduation_project/features/individuals/features/education/domain/entities/education.dart';
import 'package:graduation_project/features/individuals/features/work_experience/domain/entities/work_experience.dart';

class UserEntity extends Equatable {
  final String firstName;
  final String lastName;
  final String jobTitle;
  final String phoneNumber;
  final String email;
  final String location;
  final String summary;
  final String? videoUrl;
  final String? avatarUrl; 
  final List<WorkExperience> workExperiences;
  final List<Education> educations;

  const UserEntity({
    this.firstName = '',
    this.lastName = '',
    this.jobTitle = '',
    this.phoneNumber = '',
    this.email = '',
    this.location = '',
    this.summary = '',
    this.videoUrl,
    this.avatarUrl,
    this.workExperiences = const [],
    this.educations = const [],
  });

  UserEntity copyWith({
    String? firstName,
    String? lastName,
    String? jobTitle,
    String? phoneNumber,
    String? email,
    String? location,
    String? summary,
    String? videoUrl,
    String? avatarUrl,
    List<WorkExperience>? workExperiences,
    List<Education>? educations,
  }) {
    return UserEntity(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      jobTitle: jobTitle ?? this.jobTitle,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      location: location ?? this.location,
      summary: summary ?? this.summary,
      videoUrl: videoUrl ?? this.videoUrl,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      workExperiences: workExperiences ?? this.workExperiences,
      educations: educations ?? this.educations,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'jobTitle': jobTitle,
      'phoneNumber': phoneNumber,
      'email': email,
      'location': location,
      'summary': summary,
      'videoUrl': videoUrl,
      'avatarUrl': avatarUrl,
      'workExperiences': workExperiences.map((x) => x.toMap()).toList(),
      'educations': educations.map((x) => x.toMap()).toList(),
    };
  }

  // 2. CREATE FROM MAP (For Loading)
  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      jobTitle: map['jobTitle'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      email: map['email'] ?? '',
      location: map['location'] ?? '',
      summary: map['summary'] ?? '',
      videoUrl: map['videoUrl'],
      avatarUrl: map['avatarUrl'],
      workExperiences: List<WorkExperience>.from(
        (map['workExperiences'] as List<dynamic>? ?? []).map<WorkExperience>(
          (x) => WorkExperience.fromMap(x),
        ),
      ),
      educations: List<Education>.from(
        (map['educations'] as List<dynamic>? ?? []).map<Education>(
          (x) => Education.fromMap(x),
        ),
      ),
    );
  }

  // Helpers for JSON String
  String toJson() => json.encode(toMap());

  factory UserEntity.fromJson(String source) =>
      UserEntity.fromMap(json.decode(source));

  @override
  List<Object?> get props => [
    firstName,
    lastName,
    jobTitle,
    phoneNumber,
    email,
    location,
    summary,
    videoUrl,
    avatarUrl,
    workExperiences,
    educations,
  ];
}
