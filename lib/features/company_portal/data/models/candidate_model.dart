// lib/features/company_portal/data/models/candidate_model.dart

import 'package:dart_mappable/dart_mappable.dart';
import '../../domain/entities/candidate_entity.dart';

part 'candidate_model.mapper.dart'; // Ensure you run the code generator

@MappableClass()
class CandidateModel with CandidateModelMappable {
  final String? id;
  @MappableField(key: 'candidate_id')
  final String? candidateId;

  // Fields to capture both direct SELECTs and nested join data
  final Map<String, dynamic>? candidates;
  final String? full_name;
  final String? skills;
  final String? city;

  const CandidateModel({
    this.id,
    this.candidateId,
    this.candidates,
    this.full_name,
    this.skills,
    this.city,
  });

  // Model → Entity
  CandidateEntity toEntity() {
    final candidateIdToUse = candidateId ?? id ?? '';

    // Prioritize nested profile data from a join if available
    final profileData =
        candidates ?? {'full_name': full_name, 'skills': skills, 'city': city};

    return CandidateEntity(
      id: candidateIdToUse,
      fullName: profileData['full_name'] as String? ?? 'N/A',
      skills: profileData['skills'] as String?,
      city: profileData['city'] as String?,
    );
  }
}
