import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/individuals/features/about_me/domain/usecases/delete_about_me_video_use_case.dart';
import 'package:graduation_project/features/individuals/features/about_me/domain/usecases/save_about_me_use_case.dart';
import 'package:graduation_project/features/individuals/features/about_me/presentation/cubit/about_me_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class AboutMeCubit extends Cubit<AboutMeState> {
  final SaveAboutMeUseCase _saveAboutMeUseCase;
  final DeleteAboutMeVideoUseCase _deleteVideoUseCase;
  AboutMeCubit(this._saveAboutMeUseCase, this._deleteVideoUseCase)
    : super(const AboutMeState());

  void initialize(String? currentSummary, String? currentVideoUrl) {
    emit(
      state.copyWith(
        summary: currentSummary ?? '',
        existingVideoUrl: currentVideoUrl,
        status: FormStatus.initial,
      ),
    );
  }

  void summaryChanged(String value) {
    emit(state.copyWith(summary: value));
  }

  void videoSelected(String path) {
    emit(state.copyWith(videoPath: path));
  }

  void removeSelectedVideo() {
    emit(state.copyWith(videoPath: null));
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
          videoPath: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: FormStatus.failure));
    }
  }

  Future<void> deleteExistingVideo() async {
    if (state.status == FormStatus.loading) return;

    emit(state.copyWith(status: FormStatus.loading));

    try {
      await _deleteVideoUseCase();

      emit(state.copyWith(status: FormStatus.success, existingVideoUrl: null));
    } catch (e) {
      emit(state.copyWith(status: FormStatus.failure));
    }
  }
}
