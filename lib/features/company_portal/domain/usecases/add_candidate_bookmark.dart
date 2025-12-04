// lib/features/company_portal/domain/usecases/add_candidate_bookmark.dart

import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../../../core/error/failures.dart';
import '../repositories/company_portal_repository.dart';

@injectable
class AddCandidateBookmark {
  final CompanyRepository repository;

  AddCandidateBookmark(this.repository);

  Future<Result<void, Failure>> call(String companyId, String candidateId) {
    return repository.addCandidateBookmark(companyId, candidateId);
  }
}
