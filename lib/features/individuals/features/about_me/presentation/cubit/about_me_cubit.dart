import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/individuals/features/about_me/presentation/cubit/about_me_state.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SaveAboutMeUseCase {
  Future<String?> call(String summary, String? videoPath) async {
    // TODO: implement call
    return "";
  }
}

@injectable
class AboutMeCubit extends Cubit<AboutMeState> {
  final SaveAboutMeUseCase _saveAboutMeUseCase;

  AboutMeCubit(this._saveAboutMeUseCase) : super(const AboutMeState());

  void initialize(String currentSummary, String? currentVideoUrl) {
    emit(
      state.copyWith(
        summary: currentSummary,
        existingVideoUrl: currentVideoUrl,
      ),
    );
  }

  void summaryChanged(String value) {
    emit(state.copyWith(summary: value));
  }

  void videoSelected(String path) {
    emit(state.copyWith(videoPath: path));
  }

  Future<void> saveForm() async {
    if (state.status == FormStatus.loading) return;
    emit(state.copyWith(status: FormStatus.loading));

    try {
      final newVideoUrl = await _saveAboutMeUseCase(
        state.summary,
        state.videoPath,
      );

      emit(
        state.copyWith(
          status: FormStatus.success,
          existingVideoUrl: newVideoUrl ?? state.existingVideoUrl,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: FormStatus.failure));
    }
  }
}
