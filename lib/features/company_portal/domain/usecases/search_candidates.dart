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
    String? city,
    String? skill,
    String? experience,
  }) {
    return repository.searchCandidates(
      city: city,
      skill: skill,
      experience: experience,
    );
  }
}
