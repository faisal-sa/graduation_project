import 'package:equatable/equatable.dart';
import 'package:graduation_project/features/individuals/features/work_experience/domain/entities/work_experience.dart';

enum ListStatus { initial, loading, success, failure }

class WorkExperienceListState extends Equatable {
  final ListStatus status;
  final List<WorkExperience> experiences;
  final String? errorMessage;

  const WorkExperienceListState({
    this.status = ListStatus.initial,
    this.experiences = const [],
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, experiences, errorMessage];
}
