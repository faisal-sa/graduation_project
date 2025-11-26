import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/individuals/features/work_experience/domain/usecases/delete_work_experience_usecase.dart';
import 'package:graduation_project/features/individuals/features/work_experience/domain/usecases/get_work_experiences_usecase.dart';
import 'package:graduation_project/features/individuals/features/work_experience/presentation/cubit/list/work_experience_list_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class WorkExperienceListCubit extends Cubit<WorkExperienceListState> {
  final GetWorkExperiencesUseCase _getWorkExperiencesUseCase;
  final DeleteWorkExperienceUseCase _deleteWorkExperienceUseCase;

  WorkExperienceListCubit(
    this._getWorkExperiencesUseCase,
    this._deleteWorkExperienceUseCase,
  ) : super(const WorkExperienceListState());

  Future<void> loadExperiences() async {
    emit(const WorkExperienceListState(status: ListStatus.loading));
    try {
      final list = await _getWorkExperiencesUseCase();
      emit(
        WorkExperienceListState(status: ListStatus.success, experiences: list),
      );
    } catch (e) {
      emit(
        WorkExperienceListState(
          status: ListStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> deleteExperience(String id) async {
    try {
      await _deleteWorkExperienceUseCase(id);
      await loadExperiences();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
