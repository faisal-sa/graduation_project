import 'package:equatable/equatable.dart';
import 'package:graduation_project/features/individuals/features/work_experience/domain/entities/work_experience.dart';

enum ListStatus { initial, loading, success, failure }

class WorkExperienceState extends Equatable {
  final ListStatus status;
  final List<WorkExperience> experiences;
  final String? errorMessage;

  const WorkExperienceState({
    this.status = ListStatus.initial,
    this.experiences = const [],
    this.errorMessage,
  });

  WorkExperienceState copyWith({
    ListStatus? status,
    List<WorkExperience>? experiences,
    String? errorMessage,
  }) {
    return WorkExperienceState(
      status: status ?? this.status,
      experiences: experiences ?? this.experiences,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, experiences, errorMessage];
}
