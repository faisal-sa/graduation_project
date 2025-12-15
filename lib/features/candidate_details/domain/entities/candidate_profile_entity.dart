// lib/features/candidate_details/domain/entities/candidate_profile_entity.dart

import 'package:equatable/equatable.dart';
import 'work_experience_entity.dart';
import 'education_entity.dart';
import 'certification_entity.dart';

class CandidateProfileEntity extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String jobTitle;
  final String? aboutMe;
  final String? avatarUrl;
  final String? location;

  // New Fields
  final String? introVideoUrl;

  // ✅ 1. إضافة حقل رابط السيرة الذاتية
  final String? cvUrl;

  final List<String> employmentTypes;
  final List<String> skills;
  final bool canRelocate;
  final bool canStartImmediately;
  final List<String> languages;
  final List<String> targetRoles;
  final int? minSalary;
  final int? maxSalary;
  final String? salaryCurrency;
  final String? currentWorkStatus;
  final int? noticePeriodDays;
  final List<String> workModes;

  // Locked Fields
  final String? email;
  final String? phoneNumber;

  final List<WorkExperienceEntity> experiences;
  final List<EducationEntity> educations;
  final List<CertificationEntity> certifications;

  // Status Fields
  final bool isUnlocked;
  final bool isBookmarked;

  String get fullName => '$firstName $lastName';

  const CandidateProfileEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.jobTitle,
    this.aboutMe,
    this.avatarUrl,
    this.location,
    this.introVideoUrl,
    this.cvUrl, // ✅ إضافة للـ Constructor
    this.employmentTypes = const [],
    this.skills = const [],
    this.canRelocate = false,
    this.canStartImmediately = false,
    this.languages = const [],
    this.targetRoles = const [],
    this.minSalary,
    this.maxSalary,
    this.salaryCurrency,
    this.currentWorkStatus,
    this.noticePeriodDays,
    this.workModes = const [],
    this.email,
    this.phoneNumber,
    this.experiences = const [],
    this.educations = const [],
    this.certifications = const [],
    this.isUnlocked = false,
    this.isBookmarked = false,
  });

  CandidateProfileEntity copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? jobTitle,
    String? aboutMe,
    String? avatarUrl,
    String? location,
    String? introVideoUrl,
    String? cvUrl, // ✅ إضافة هنا
    List<String>? employmentTypes,
    List<String>? skills,
    bool? canRelocate,
    bool? canStartImmediately,
    List<String>? languages,
    List<String>? targetRoles,
    int? minSalary,
    int? maxSalary,
    String? salaryCurrency,
    String? currentWorkStatus,
    int? noticePeriodDays,
    List<String>? workModes,
    String? email,
    String? phoneNumber,
    List<WorkExperienceEntity>? experiences,
    List<EducationEntity>? educations,
    List<CertificationEntity>? certifications,
    bool? isUnlocked,
    bool? isBookmarked,
  }) {
    return CandidateProfileEntity(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      jobTitle: jobTitle ?? this.jobTitle,
      aboutMe: aboutMe ?? this.aboutMe,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      location: location ?? this.location,
      introVideoUrl: introVideoUrl ?? this.introVideoUrl,
      cvUrl: cvUrl ?? this.cvUrl, // ✅ التحديث هنا
      employmentTypes: employmentTypes ?? this.employmentTypes,
      skills: skills ?? this.skills,
      canRelocate: canRelocate ?? this.canRelocate,
      canStartImmediately: canStartImmediately ?? this.canStartImmediately,
      languages: languages ?? this.languages,
      targetRoles: targetRoles ?? this.targetRoles,
      minSalary: minSalary ?? this.minSalary,
      maxSalary: maxSalary ?? this.maxSalary,
      salaryCurrency: salaryCurrency ?? this.salaryCurrency,
      currentWorkStatus: currentWorkStatus ?? this.currentWorkStatus,
      noticePeriodDays: noticePeriodDays ?? this.noticePeriodDays,
      workModes: workModes ?? this.workModes,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      experiences: experiences ?? this.experiences,
      educations: educations ?? this.educations,
      certifications: certifications ?? this.certifications,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      isBookmarked: isBookmarked ?? this.isBookmarked,
    );
  }

  @override
  List<Object?> get props => [
    id,
    firstName,
    lastName,
    jobTitle,
    aboutMe,
    avatarUrl,
    location,
    introVideoUrl,
    cvUrl, // ✅ إضافته للمقارنة
    employmentTypes,
    skills,
    canRelocate,
    canStartImmediately,
    languages,
    targetRoles,
    minSalary,
    maxSalary,
    salaryCurrency,
    currentWorkStatus,
    noticePeriodDays,
    workModes,
    email,
    phoneNumber,
    experiences,
    educations,
    certifications,
    isUnlocked,
    isBookmarked,
  ];
}
