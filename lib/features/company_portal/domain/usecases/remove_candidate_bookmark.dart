// lib/features/company_portal/domain/usecases/remove_candidate_bookmark.dart

import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../../../core/error/failures.dart';
import '../repositories/company_portal_repository.dart';

@lazySingleton
class RemoveCandidateBookmark {
  final CompanyRepository repository;

  RemoveCandidateBookmark(this.repository);

  Future<Result<void, Failure>> call(
    String companyId,
    String candidateId,
  ) async {
    return await repository.removeCandidateBookmark(companyId, candidateId);
  }
}
