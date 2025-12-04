import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graduation_project/features/individuals/features/job_preferences/domain/usecases/get_job_preferences_usecase.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/job_preferences_entity.dart';
import '../../domain/usecases/update_job_preferences_usecase.dart';

part 'job_preferences_state.dart';

@injectable
class JobPreferencesCubit extends Cubit<JobPreferencesState> {
  final GetJobPreferencesUseCase _getJobPreferencesUseCase;
  final UpdateJobPreferencesUseCase _updateJobPreferencesUseCase;

  JobPreferencesCubit(
    this._getJobPreferencesUseCase,
    this._updateJobPreferencesUseCase,
  ) : super(JobPreferencesInitial());

  Future<void> loadPreferences() async {
    emit(JobPreferencesLoading());
    final result = await _getJobPreferencesUseCase();

    result.fold(
      (failure) => emit(JobPreferencesError(failure.message)),
      (preferences) => emit(JobPreferencesLoaded(preferences)),
    );
  }

  Future<void> savePreferences(JobPreferencesEntity preferences) async {
    // Optimistic update or show loading
    emit(JobPreferencesLoading());

    final result = await _updateJobPreferencesUseCase(preferences);

    result.fold((failure) => emit(JobPreferencesError(failure.message)), (_) {
      emit(JobPreferencesSaved());
      // Optionally reload data to confirm consistency
      emit(JobPreferencesLoaded(preferences));
    });
  }
}


// abstract class JobPreferencesState {}
// class JobPreferencesInitial extends JobPreferencesState {}
// class JobPreferencesLoading extends JobPreferencesState {}
// class JobPreferencesLoaded extends JobPreferencesState {
//   final JobPreferencesEntity preferences;
//   JobPreferencesLoaded(this.preferences);
// }
// class JobPreferencesSaved extends JobPreferencesState {}
// class JobPreferencesError extends JobPreferencesState {
//   final String message;
//   JobPreferencesError(this.message);
// }

// class JobPreferencesCubit extends Cubit<JobPreferencesState> {
//   JobPreferencesCubit() : super(JobPreferencesInitial());
//   void loadPreferences() { /* Load logic */ }
//   void savePreferences(JobPreferencesEntity entity) { /* Save logic */ }
// }