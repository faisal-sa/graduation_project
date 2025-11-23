import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/core/di/service_locator.dart';

import 'package:graduation_project/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:graduation_project/features/profile/presentation/pages/profile_page.dart';
import 'package:graduation_project/features/auth/presentation/pages/login_page.dart';
import 'package:graduation_project/features/auth/presentation/pages/signup_page.dart';
import 'package:graduation_project/features/auth/presentation/pages/otp_verification_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const LoginPage(); //spalsh later page
      },
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) {
        return const SignupPage();
      },
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) {
        return const LoginPage();
      },
    ),
    GoRoute(
      path: '/otp-verification',
      builder: (context, state) {
        final email = state.extra as String? ?? '';
        return OTPVerificationPage(email: email);
      },
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) {
        return BlocProvider(
          create: (context) => serviceLocator.get<ProfileCubit>(),
          child: ProfilePage(),
        );
      },
    ),
  ],
);
