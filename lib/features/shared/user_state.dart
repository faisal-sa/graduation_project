import 'package:equatable/equatable.dart';
import 'user_entity.dart';

class UserState extends Equatable {
  final UserEntity user;

  const UserState({this.user = const UserEntity()});

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

    checkList(user.workExperiences);

    return total == 0 ? 0.0 : (filled / total);
  }

  UserState copyWith({UserEntity? user}) {
    return UserState(user: user ?? this.user);
  }

  @override
  List<Object> get props => [user];
}
