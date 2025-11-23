part of 'profile_cubit.dart';

@immutable
class ProfileState extends Equatable {
  final File? image;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String location;
  final int currentPage;

  const ProfileState({
    this.image,
    this.fullName = '',
    this.email = '',
    this.phoneNumber = '',
    this.location = '',
    this.currentPage = 0,
  });

  ProfileState copyWith({
    File? image,
    String? fullName,
    String? email,
    String? phoneNumber,
    String? location,
    int? currentPage,
  }) {
    return ProfileState(
      image: image ?? this.image,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      location: location ?? this.location,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  bool get stringify => true;
  @override
  List<Object?> get props => [
    image,
    fullName,
    email,
    phoneNumber,
    location,
    currentPage,
  ];
}
