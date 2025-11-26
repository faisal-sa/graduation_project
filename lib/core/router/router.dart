import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/core/di/service_locator.dart';
import 'package:graduation_project/features/company_portal/presentation/blocs/bloc/company_bloc.dart';
import 'package:graduation_project/features/company_portal/presentation/screens/company_bookmarks_page.dart';
import 'package:graduation_project/features/company_portal/presentation/screens/company_home_page.dart';
import 'package:graduation_project/features/company_portal/presentation/screens/company_profile_page.dart';
import 'package:graduation_project/features/company_portal/presentation/screens/company_qr_scanner_page.dart';
import 'package:graduation_project/features/company_portal/presentation/screens/company_search_page.dart';
import 'package:graduation_project/features/individuals/chat/presentation/pages/chats_tab.dart';
import 'package:graduation_project/features/individuals/features/about_me/presentation/cubit/about_me_cubit.dart';
import 'package:graduation_project/features/individuals/features/about_me/presentation/pages/about_me_page.dart';
import 'package:graduation_project/features/individuals/features/basic_info/presentation/cubit/basic_info_cubit.dart';
import 'package:graduation_project/features/individuals/features/basic_info/presentation/pages/basic_info_page.dart';
import 'package:graduation_project/features/individuals/insights/presentation/pages/insights_tab.dart';
import 'package:graduation_project/features/individuals/profile/presentation/cubit/profile_cubit.dart';
import 'package:graduation_project/features/individuals/profile/presentation/pages/profile_tab.dart';
import 'package:graduation_project/features/individuals/navigation/pages/individuals_home_page.dart';

import 'package:graduation_project/features/auth/presentation/pages/login_page.dart';
import 'package:graduation_project/features/auth/presentation/pages/signup_page.dart';
import 'package:graduation_project/features/auth/presentation/pages/otp_verification_page.dart';

import 'package:flutter/material.dart';
import 'package:graduation_project/features/shared/user_cubit.dart';

// keep it here for now
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const LoginPage()),
    GoRoute(path: '/signup', builder: (context, state) => const SignupPage()),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(
      path: '/otp-verification',
      builder: (context, state) {
        final email = state.extra as String? ?? '';
        return OTPVerificationPage(email: email);
      },
    ),

    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(value: serviceLocator.get<UserCubit>()),
            BlocProvider(create: (context) => ProfileCubit()),
          ],
          child: IndividualsHomePage(navigationShell: navigationShell),
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/insights',
              builder: (context, state) => const InsightsTab(),
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/chats',
              builder: (context, state) => const ChatsTab(),
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileTab(),
              routes: [
                GoRoute(
                  path: 'basic-info',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    final userCubit = serviceLocator.get<UserCubit>();

                    return MultiBlocProvider(
                      providers: [
                        BlocProvider.value(value: userCubit),
                        BlocProvider(
                          create: (context) {
                            final cubit = serviceLocator.get<BasicInfoCubit>();
                            cubit.initialize(userCubit.state.user);
                            return cubit;
                          },
                        ),
                      ],
                      child: const BasicInfoPage(),
                    );
                  },
                ),
                GoRoute(
                  path: 'about-me',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    final userCubit = serviceLocator.get<UserCubit>();

                    return MultiBlocProvider(
                      providers: [
                        BlocProvider.value(value: userCubit),

                        BlocProvider(
                          create: (context) {
                            final cubit = serviceLocator.get<AboutMeCubit>();
                            final currentUser = userCubit.state.user;

                            cubit.initialize(
                              currentUser.summary,
                              currentUser.videoUrl,
                            );
                            return cubit;
                          },
                        ),
                      ],
                      child: const AboutMePage(),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    // --------------------- Company Routes with Bloc ---------------------
    ShellRoute(
      builder: (context, state, child) {
        return BlocProvider(
          create: (_) => serviceLocator.get<CompanyBloc>(),
          child: child,
        );
      },
      routes: [
        GoRoute(path: '/company', builder: (_, __) => const CompanyHomePage()),
        GoRoute(
          path: '/company/profile',
          builder: (_, __) => const CompanyProfilePage(),
        ),
        GoRoute(
          path: '/company/search',
          builder: (_, __) => const CompanySearchPage(),
        ),
        GoRoute(
          path: '/company/bookmarks',
          builder: (_, __) => const CompanyBookmarksPage(),
        ),
        GoRoute(
          path: '/company/scan',
          builder: (_, __) => const CompanyQrScannerPage(),
        ),
      ],
    ),
  ],
);
