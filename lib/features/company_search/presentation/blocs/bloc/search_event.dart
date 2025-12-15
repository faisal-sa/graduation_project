part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
  @override
  List<Object?> get props => [];
}

class PerformSearchEvent extends SearchEvent {
  final String? location;
  final List<String>? skills;
  final List<String>? employmentTypes;
  final bool? canRelocate;
  final List<String>? languages;
  final List<String>? workModes;
  final String? jobTitle;
  final List<String>? targetRoles;

  const PerformSearchEvent({
    this.location,
    this.skills,
    this.employmentTypes,
    this.canRelocate,
    this.languages,
    this.workModes,
    this.jobTitle,
    this.targetRoles,
  });

  @override
  List<Object?> get props => [
    location,
    skills,
    employmentTypes,
    canRelocate,
    languages,
    workModes,
    jobTitle,
    targetRoles,
  ];
}

class ResetSearchEvent extends SearchEvent {}

class UpdateLocalBookmarkEvent extends SearchEvent {
  final String candidateId;
  final bool isBookmarked;

  const UpdateLocalBookmarkEvent({
    required this.candidateId,
    required this.isBookmarked,
  });

  @override
  List<Object?> get props => [candidateId, isBookmarked];
}
