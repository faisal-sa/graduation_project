// lib/features/company_portal/domain/usecases/search_candidates.dart

import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../../../core/error/failures.dart';
import '../entities/candidate_entity.dart';
import '../repositories/company_portal_repository.dart';

@injectable
class SearchCandidates {
  final CompanyRepository repository;

  SearchCandidates(this.repository);

  Future<Result<List<CandidateEntity>, Failure>> call({
    String? location,
    List<String>? skills,
    List<String>? employmentTypes,
    bool? canRelocate,
    List<String>? languages,
    List<String>? workModes,
    String? jobTitle,
    List<String>? targetRoles,
  }) {
    return repository.searchCandidates(
      location: location,
      skills: skills,
      employmentTypes: employmentTypes,
      canRelocate: canRelocate,
      languages: languages,
      workModes: workModes,
      jobTitle: jobTitle,
      targetRoles: targetRoles,
    );
  }
}
