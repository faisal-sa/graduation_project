import 'package:injectable/injectable.dart';
import '../models/ai_score_model.dart';

@singleton
class AiLocalDataSource {
  final Map<String, AiScoreModel> _cache = {};

  AiScoreModel? getCachedAnalysis(String key) {
    if (_cache.containsKey(key)) {
      return _cache[key];
    }
    return null;
  }

  void cacheAnalysis(String key, AiScoreModel model) {
    _cache[key] = model;
  }

  void clearCache() {
    _cache.clear();
  }
}
