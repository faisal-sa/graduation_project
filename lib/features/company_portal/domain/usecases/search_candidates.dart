import 'package:graduation_project/features/company_portal/domain/repositories/company_portal_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class SearchCandidates {
  final CompanyRepository repo;
  SearchCandidates(this.repo);

  Future<Result<List<Map<String, dynamic>>, String>> call({
    String? city,
    String? skill,
    String? experience,
  }) {
    return repo.searchCandidates(
      city: city,
      skill: skill,
      experience: experience,
    );
  }
}
