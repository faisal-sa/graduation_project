// lib/features/company_portal/domain/usecases/get_company_bookmarks.dart

import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../../../core/error/failures.dart';
import '../entities/candidate_entity.dart';
import '../repositories/company_portal_repository.dart';

@injectable
class GetCompanyBookmarks {
  final CompanyRepository repository;

  GetCompanyBookmarks(this.repository);

  Future<Result<List<CandidateEntity>, Failure>> call(String companyId) {
    return repository.getCompanyBookmarks(companyId);
  }
}
