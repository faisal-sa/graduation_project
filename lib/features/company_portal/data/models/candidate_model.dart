import 'package:dart_mappable/dart_mappable.dart';
import '../../domain/entities/candidate_entity.dart';

part 'candidate_model.mapper.dart';

@MappableClass()
class CandidateModel with CandidateModelMappable {
  final String? id;

  @MappableField(key: 'candidate_id')
  final String? candidateId;

  final Map<String, dynamic>? profiles;

  final String? first_name;
  final String? last_name;
  final String? location;
  final String? job_title;
  final dynamic skills;
  final String? avatar_url;

  const CandidateModel({
    this.id,
    this.candidateId,
    this.profiles,
    this.first_name,
    this.last_name,
    this.location,
    this.job_title,
    this.skills,
    this.avatar_url,
  });

  CandidateEntity toEntity() {
    final candidateIdToUse = candidateId ?? id ?? '';

    final source =
        profiles ??
        {
          'first_name': first_name,
          'last_name': last_name,
          'location': location,
          'job_title': job_title,
          'skills': skills,
          'avatar_url': avatar_url,
        };

    final fName = source['first_name'] as String? ?? '';
    final lName = source['last_name'] as String? ?? '';
    String fullName = '$fName $lName'.trim();
    if (fullName.isEmpty) fullName = 'Unnamed Candidate';

    final city = source['location'] as String? ?? 'Unknown location';

    final job = source['job_title'] as String? ?? 'Open to work';

    final rawSkills = source['skills'];
    String normalizedSkills = 'No skills';

    if (rawSkills is List) {
      normalizedSkills = rawSkills.join(', ');
    } else if (rawSkills is String) {
      normalizedSkills = rawSkills.replaceAll(RegExp(r'[\[\]{}"]'), '').trim();
    }
    final image = source['avatar_url'] as String?;

    return CandidateEntity(
      id: candidateIdToUse,
      fullName: fullName,
      skills: normalizedSkills,
      city: city,
      jobTitle: job,
      avatarUrl: image,
    );
  }
}
