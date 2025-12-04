part of 'job_preferences_cubit.dart';

abstract class JobPreferencesState extends Equatable {
  const JobPreferencesState();

  @override
  List<Object> get props => [];
}

class JobPreferencesInitial extends JobPreferencesState {}

class JobPreferencesLoading extends JobPreferencesState {}

class JobPreferencesLoaded extends JobPreferencesState {
  final JobPreferencesEntity preferences;

  const JobPreferencesLoaded(this.preferences);

  @override
  List<Object> get props => [preferences];
}

class JobPreferencesError extends JobPreferencesState {
  final String message;

  const JobPreferencesError(this.message);

  @override
  List<Object> get props => [message];
}

class JobPreferencesSaved extends JobPreferencesState {}
