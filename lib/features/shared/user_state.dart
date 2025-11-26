import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'user_entity.dart';

class UserState extends Equatable {
  final UserEntity user;

  const UserState({this.user = const UserEntity()});

  double get profileCompletion {
    int total = 0;
    int filled = 0;

    void check(String? val) {
      total++;
      if (val != null && val.isNotEmpty) filled++;
    }

    check(user.firstName);
    check(user.lastName);
    check(user.jobTitle);
    check(user.location);
    check(user.email);
    check(user.phoneNumber);
    check(user.summary);

    return total == 0 ? 0.0 : (filled / total);
  }

  UserState copyWith({UserEntity? user}) {
    return UserState(user: user ?? this.user);
  }

  @override
  List<Object> get props => [user];
}
