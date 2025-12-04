import 'package:equatable/equatable.dart';

class BasicInfoEntity extends Equatable {
  final String firstName;
  final String lastName;
  final String jobTitle;
  final String phoneNumber;
  final String email;
  final String location;

  const BasicInfoEntity({
    required this.firstName,
    required this.lastName,
    required this.jobTitle,
    required this.phoneNumber,
    required this.email,
    required this.location,
  });

  @override
  List<Object?> get props => [
    firstName,
    lastName,
    jobTitle,
    phoneNumber,
    email,
    location,
  ];
}
