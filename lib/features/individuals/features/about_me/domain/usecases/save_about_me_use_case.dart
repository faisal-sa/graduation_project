import 'package:injectable/injectable.dart';
import '../repositories/about_me_repository.dart';

@lazySingleton
class SaveAboutMeUseCase {
  final AboutMeRepository _repository;

  SaveAboutMeUseCase(this._repository);

  Future<String?> call(String summary, String? videoPath) async {
    return await _repository.updateAboutMe(
      summary: summary,
      videoPath: videoPath,
    );
  }
}
