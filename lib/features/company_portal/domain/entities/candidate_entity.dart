import 'package:equatable/equatable.dart';

class CandidateEntity extends Equatable {
  final String id;
  final String fullName;
  final String? skills;
  final String? city;

  const CandidateEntity({
    required this.id,
    required this.fullName,
    this.skills,
    this.city,
  });

  @override
  List<Object?> get props => [id, fullName, skills, city];
}
