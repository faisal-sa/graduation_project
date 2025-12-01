import 'package:equatable/equatable.dart';
import 'package:graduation_project/features/individuals/features/education/domain/entities/education.dart';
import 'package:graduation_project/features/individuals/features/work_experience/domain/entities/work_experience.dart';
// --- UPDATED USER ENTITY ---

class UserEntity extends Equatable {
  final String firstName;
  final String lastName;
  final String jobTitle;
  final String phoneNumber;
  final String email;
  final String location;
  final String summary;
  final String? videoUrl;
  final String? avatarUrl; // <--- ADDED THIS
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
    this.avatarUrl, // <--- ADDED THIS
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

extension StringExtension on String {
  String take(int n) {
    if (this.length <= n) return this;
    return this.substring(0, n);
  }
}
