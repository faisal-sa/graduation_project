import 'package:multiple_result/multiple_result.dart';
import '../repositories/company_portal_repository.dart';

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
