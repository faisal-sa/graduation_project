import 'package:graduation_project/features/shared/data/domain/entities/candidate_entity.dart';
import 'package:graduation_project/features/company_search/data/data_sources/company_search_data_source.dart';
import 'package:graduation_project/features/company_search/domain/repositories/company_search_repository.dart';
import 'package:graduation_project/features/shared/data/models/candidate_model.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../core/error/failures.dart';

@Injectable(as: SearchRepository)
class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource _remoteDataSource;

  SearchRepositoryImpl(this._remoteDataSource);

  Failure _mapExceptionToFailure(Exception e) {
    if (e.toString().contains('SupabaseException')) {
      return ServerFailure(e.toString());
    }
    return UnknownFailure(e.toString());
  }

  @override
  Future<Result<List<CandidateEntity>, Failure>> searchCandidates({
    String? location,
    List<String>? skills,
    List<String>? employmentTypes,
    bool? canRelocate,
    List<String>? languages,
    List<String>? workModes,
    String? jobTitle,
    List<String>? targetRoles,
  }) async {
    try {
      final results = await _remoteDataSource.searchCandidates(
        location: location,
        skills: skills,
        employmentTypes: employmentTypes,
        canRelocate: canRelocate,
        languages: languages,
        workModes: workModes,
        jobTitle: jobTitle,
        targetRoles: targetRoles,
      );

      final entities = results.map<CandidateEntity>((data) {
        final CandidateModel model = CandidateModelMapper.ensureInitialized()
            .decodeMap(data);
        return model.toEntity();
      }).toList();

      return Success(entities);
    } on Exception catch (e) {
      return Error(_mapExceptionToFailure(e));
    }
  }
}
