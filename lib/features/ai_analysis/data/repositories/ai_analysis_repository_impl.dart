import 'package:graduation_project/features/ai_analysis/data/data_sources/ai_analysis_data_source.dart';
import 'package:graduation_project/features/ai_analysis/data/data_sources/ai_local_data_source.dart';
import 'package:graduation_project/features/ai_analysis/domain/repositories/ai_analysis_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../../../core/error/failures.dart';
import '../models/ai_score_model.dart';
import 'package:flutter/foundation.dart';

@Injectable(as: AiRepository)
class AiRepositoryImpl implements AiRepository {
  final AiRemoteDataSource _remoteDataSource;
  final AiLocalDataSource _localDataSource;

  AiRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Result<AiScoreModel, Failure>> getAnalysis({
    required Map<String, dynamic> candidateData,
    required Map<String, dynamic> jobRequirements,
  }) async {
    final String cacheKey =
        '${candidateData['name']}_${jobRequirements['target_title']}';

    try {
      final cachedResult = _localDataSource.getCachedAnalysis(cacheKey);
      if (cachedResult != null) {
        if (kDebugMode) print("💾 Returning Cached Analysis for $cacheKey");
        return Success(cachedResult);
      }

      final result = await _remoteDataSource.analyzeCandidate(
        candidateData: candidateData,
        jobRequirements: jobRequirements,
      );

      _localDataSource.cacheAnalysis(cacheKey, result);

      return Success(result);
    } catch (e) {
      return Error(ServerFailure(e.toString()));
    }
  }
}
