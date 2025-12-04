import 'package:equatable/equatable.dart';
import 'user_entity.dart';

class UserState extends Equatable {
  final UserEntity user;
  final bool isResumeLoading;
  final String? resumeError;

  const UserState({
    this.user = const UserEntity(),
    this.isResumeLoading = false,
    this.resumeError,
  });

  double get profileCompletion {
    int total = 0;
    int filled = 0;

    void checkString(String? val) {
      total++;
      if (val != null && val.isNotEmpty) filled++;
    }

    void checkList(List? list) {
      total++;
      if (list != null && list.isNotEmpty) filled++;
    }

    checkString(user.firstName);
    checkString(user.lastName);
    checkString(user.jobTitle);
    checkString(user.location);
    checkString(user.email);
    checkString(user.phoneNumber);
    checkString(user.summary);
    checkString(user.avatarUrl); 
    checkList(user.workExperiences);
    checkList(user.educations);

    return total == 0 ? 0.0 : (filled / total);
  }

  UserState copyWith({
    UserEntity? user,
    bool? isResumeLoading,
    String? resumeError,
  }) {
    return UserState(
      user: user ?? this.user,
      isResumeLoading: isResumeLoading ?? this.isResumeLoading,
      resumeError: resumeError,
    );
  }

  @override
  List<Object?> get props => [user, isResumeLoading, resumeError];
}
