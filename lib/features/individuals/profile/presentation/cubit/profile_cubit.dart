import 'package:bloc/bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileInitial());

  void onBasicInfoTapped() {
    emit(ProfileNavigateTo(ProfileRoutes.basicInfo));
  }

  void onAboutMeTapped() {
    emit(ProfileNavigateTo(ProfileRoutes.aboutMe));
  }

  void onWorkExperienceTapped() {
    emit(ProfileNavigateTo(ProfileRoutes.experience));
  }

  void onEducationTapped() {
    emit(ProfileNavigateTo(ProfileRoutes.education));
  }

  void onCertificationsTapped() {
    emit(ProfileNavigateTo(ProfileRoutes.certification));
  }

  void onSkillsTapped() {
    emit(ProfileNavigateTo(ProfileRoutes.skills));
  }

  void onJobPreferencesTapped() {
    emit(ProfileNavigateTo(ProfileRoutes.jobPreferences));
  }
}
