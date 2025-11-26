import 'package:equatable/equatable.dart';
import 'package:graduation_project/features/individuals/features/work_experience/domain/entities/work_experience.dart';
import 'package:graduation_project/features/individuals/features/work_experience/presentation/pages/work_experience_page.dart';

class UserEntity extends Equatable {
  final String firstName;
  final String lastName;
  final String jobTitle;
  final String phoneNumber;
  final String email;
  final String location;
  final String summary;
  final String? videoUrl;
  final List<WorkExperience> workExperiences;

  const UserEntity({
    this.firstName = '',
    this.lastName = '',
    this.jobTitle = '',
    this.phoneNumber = '',
    this.email = '',
    this.location = '',
    this.summary = '',
    this.videoUrl,
    this.workExperiences = const [],
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
    List<WorkExperience>? workExperiences,
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
      workExperiences: workExperiences ?? this.workExperiences,
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
    workExperiences,
  ];
}
