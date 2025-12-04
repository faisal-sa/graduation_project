import 'package:equatable/equatable.dart';
import 'package:graduation_project/features/individuals/features/education/domain/entities/education.dart';

enum ListStatus { initial, loading, success, failure }

class EducationState extends Equatable {
  final ListStatus status;
  final List<Education> educations;
  final String? errorMessage;

  const EducationState({
    this.status = ListStatus.initial,
    this.educations = const [],
    this.errorMessage,
  });

  EducationState copyWith({
    ListStatus? status,
    List<Education>? educations,
    String? errorMessage,
  }) {
    return EducationState(
      status: status ?? this.status,
      educations: educations ?? this.educations,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, educations, errorMessage];
}
