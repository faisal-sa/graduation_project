import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/individuals/features/work_experience/domain/entities/work_experience.dart';
import 'package:graduation_project/features/individuals/features/work_experience/domain/usecases/add_work_experience_usecase.dart';
import 'package:graduation_project/features/individuals/features/work_experience/domain/usecases/update_work_experience_usecase.dart';
import 'package:graduation_project/features/individuals/features/work_experience/presentation/cubit/form/work_experience_form_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class WorkExperienceFormCubit extends Cubit<WorkExperienceFormState> {
  final AddWorkExperienceUseCase _addUseCase;
  final UpdateWorkExperienceUseCase _updateUseCase;

  String? _editingId;

  WorkExperienceFormCubit(this._addUseCase, this._updateUseCase)
    : super(const WorkExperienceFormState());

  void initializeForEdit(WorkExperience experience) {
    _editingId = experience.id;
    emit(
      state.copyWith(
        jobTitle: experience.jobTitle,
        companyName: experience.companyName,
        location: experience.location,
        employmentType: experience.employmentType,
        startDate: experience.startDate,
        endDate: experience.endDate,
        isCurrentlyWorking: experience.isCurrentlyWorking,
        responsibilities: experience.responsibilities,
        status: FormStatus.initial,
      ),
    );
  }

  void jobTitleChanged(String val) => emit(state.copyWith(jobTitle: val));
  void companyNameChanged(String val) => emit(state.copyWith(companyName: val));
  void locationChanged(String val) => emit(state.copyWith(location: val));
  void employmentTypeChanged(String val) =>
      emit(state.copyWith(employmentType: val));
  void startDateChanged(DateTime date) => emit(state.copyWith(startDate: date));
  void endDateChanged(DateTime date) {
    if (!state.isCurrentlyWorking) emit(state.copyWith(endDate: date));
  }

  void currentWorkingChanged(bool val) => emit(
    state.copyWith(
      isCurrentlyWorking: val,
      endDate: val ? null : state.endDate,
    ),
  );
  void addResponsibility(String item) {
    if (item.trim().isNotEmpty) {
      emit(
        state.copyWith(
          responsibilities: List.from(state.responsibilities)..add(item.trim()),
        ),
      );
    }
  }

  void removeResponsibility(int index) => emit(
    state.copyWith(
      responsibilities: List.from(state.responsibilities)..removeAt(index),
    ),
  );

  Future<void> submitForm() async {
    if (state.jobTitle.isEmpty ||
        state.companyName.isEmpty ||
        state.startDate == null) {
      emit(
        state.copyWith(
          status: FormStatus.failure,
          errorMessage: "Missing required fields",
        ),
      );
      return;
    }

    emit(state.copyWith(status: FormStatus.loading));

    try {
      final experience = WorkExperience(
        id: _editingId ?? '',
        jobTitle: state.jobTitle,
        companyName: state.companyName,
        employmentType: state.employmentType,
        location: state.location,
        responsibilities: state.responsibilities,
        startDate: state.startDate!,
        endDate: state.isCurrentlyWorking ? null : state.endDate,
        isCurrentlyWorking: state.isCurrentlyWorking,
      );

      if (_editingId != null) {
        await _updateUseCase(experience);
      } else {
        await _addUseCase(experience);
      }

      emit(state.copyWith(status: FormStatus.success));
    } catch (e) {
      emit(
        state.copyWith(status: FormStatus.failure, errorMessage: e.toString()),
      );
    }
  }
}
