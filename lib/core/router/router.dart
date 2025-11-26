import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/core/di/service_locator.dart';

import 'package:graduation_project/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:graduation_project/features/profile/presentation/pages/profile_page.dart';
import 'package:graduation_project/features/auth/presentation/pages/login_page.dart';
import 'package:graduation_project/features/auth/presentation/pages/signup_page.dart';
import 'package:graduation_project/features/auth/presentation/pages/otp_verification_page.dart';

import '../../features/CRinfo/cr_info_page.dart';
import '../../features/payment/pay_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/pay',
  routes: [
    //▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲ ROUTE START ▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼
    //
    // ==================  CR Info Page  =================== //
    //
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const CrInfoPage(); //spalsh later page
      },
    ),

    // ==================  Signup Page  =================== //
    //
    GoRoute(
      path: '/signup',
      builder: (context, state) {
        return const SignupPage();
      },
    ),

    // ==================  Login Page  =================== //
    //
    GoRoute(
      path: '/login',
      builder: (context, state) {
        return const LoginPage();
      },
    ),

    // ==================  OTP Verification Page  =================== //
    //
    GoRoute(
      path: '/otp-verification',
      builder: (context, state) {
        final email = state.extra as String? ?? '';
        return OTPVerificationPage(email: email);
      },
    ),

    // ==================  Profile Page  =================== //
    //
    GoRoute(
      path: '/profile',
      builder: (context, state) {
        return BlocProvider(
          create: (context) => serviceLocator.get<ProfileCubit>(),
          child: ProfilePage(),
        );
      },
    ),

    // ==================  Pay Page  =================== //
    //
    GoRoute(
      path: '/pay',
      builder: (context, state) {
        return const PayPage();
      },
    ),

    //▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲ ROUTE END ▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼
  ],
);
