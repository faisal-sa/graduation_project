import 'package:equatable/equatable.dart';

class CandidateEntity extends Equatable {
  final String id;
  final String fullName;
  final String? skills;
  final String? city;
  final bool bookmarked;
  final String? jobTitle;
  final String? avatarUrl;

  const CandidateEntity({
    required this.id,
    required this.fullName,
    this.skills,
    this.city,
    this.bookmarked = false,
    this.jobTitle,
    this.avatarUrl,
  });

  CandidateEntity copyWith({
    String? id,
    String? fullName,
    String? skills,
    String? city,
    bool? bookmarked,
    String? jobTitle,
    String? avatarUrl,
  }) {
    return CandidateEntity(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      skills: skills ?? this.skills,
      city: city ?? this.city,
      bookmarked: bookmarked ?? this.bookmarked,
      jobTitle: jobTitle ?? this.jobTitle,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [
    id,
    fullName,
    skills,
    city,
    bookmarked,
    jobTitle,
    avatarUrl,
  ];
}
