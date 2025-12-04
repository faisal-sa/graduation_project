part of 'profile_cubit.dart';

abstract class ProfileState {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileNavigateTo extends ProfileState {
  final String route;

  final DateTime timestamp;

  ProfileNavigateTo(this.route) : timestamp = DateTime.now();
}

class ProfileRoutes {
  static const String basicInfo = '/profile/basic-info';
  static const String aboutMe = '/profile/about-me';
  static const String experience = '/profile/experience';
  static const String education = '/profile/education';
  static const String skills = '/profile/skills';
  static const String jobPreferences = '/profile/preferences';
  static const String certification = '/profile/certification';
}
