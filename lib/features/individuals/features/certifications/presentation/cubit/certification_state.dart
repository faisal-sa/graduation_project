import 'package:equatable/equatable.dart';
import 'package:graduation_project/features/individuals/features/certifications/domain/entities/certification.dart';
import 'package:graduation_project/features/individuals/features/work_experience/presentation/cubit/work_experience_state.dart';

class CertificationState extends Equatable {
  final ListStatus status;
  final List<Certification> certifications;
  final String? errorMessage;

  const CertificationState({
    this.status = ListStatus.initial,
    this.certifications = const [],
    this.errorMessage,
  });

  CertificationState copyWith({
    ListStatus? status,
    List<Certification>? certifications,
    String? errorMessage,
  }) {
    return CertificationState(
      status: status ?? this.status,
      certifications: certifications ?? this.certifications,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, certifications, errorMessage];
}
