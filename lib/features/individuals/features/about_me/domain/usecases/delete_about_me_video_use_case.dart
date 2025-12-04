import 'package:injectable/injectable.dart';
import '../repositories/about_me_repository.dart';

@lazySingleton
class DeleteAboutMeVideoUseCase {
  final AboutMeRepository _repository;

  DeleteAboutMeVideoUseCase(this._repository);

  Future<void> call() async {
    return await _repository.deleteVideo();
  }
}
