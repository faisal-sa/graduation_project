import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/individuals/features/education/domain/entities/education.dart';
import 'package:graduation_project/features/individuals/features/education/domain/usecases/add_education_usecase.dart';
import 'package:graduation_project/features/individuals/features/education/domain/usecases/delete_education_usecase.dart';
import 'package:graduation_project/features/individuals/features/education/domain/usecases/get_educations_usecase.dart';
import 'package:graduation_project/features/individuals/features/education/domain/usecases/update_education_usecase.dart';
import 'package:injectable/injectable.dart';
import 'education_state.dart';

@injectable
class EducationCubit extends Cubit<EducationState> {
  final GetEducationsUseCase _getEducationsUseCase;
  final DeleteEducationUseCase _deleteEducationUseCase;
  final AddEducationUseCase _addEducationUseCase;
  final UpdateEducationUseCase _updateEducationUseCase;

  EducationCubit(
    this._getEducationsUseCase,
    this._deleteEducationUseCase,
    this._addEducationUseCase,
    this._updateEducationUseCase,
  ) : super(const EducationState());

  Future<void> loadEducations() async {
    emit(const EducationState(status: ListStatus.loading));
    try {
      final list = await _getEducationsUseCase();
      emit(EducationState(status: ListStatus.success, educations: list));
    } catch (e) {
      emit(
        EducationState(status: ListStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  Future<void> addEducation(Education education) async {
    try {
      await _addEducationUseCase(education);
      final currentList = List<Education>.from(state.educations);
      currentList.add(education);
      emit(state.copyWith(educations: currentList));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> updateEducation(Education education) async {
    try {
      await _updateEducationUseCase(education);
      final currentList = List<Education>.from(state.educations);
      final index = currentList.indexWhere((e) => e.id == education.id);
      if (index != -1) {
        currentList[index] = education;
        emit(state.copyWith(educations: currentList));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> deleteEducation(String id) async {
    try {
      await _deleteEducationUseCase(id);
      final currentList = List<Education>.from(state.educations);
      currentList.removeWhere((e) => e.id == id);
      emit(state.copyWith(educations: currentList));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
