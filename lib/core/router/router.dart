import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/features/company_portal/presentation/blocs/bloc/company_bloc.dart';
import 'package:graduation_project/features/company_portal/presentation/screens/advanced_searchpage.dart';
import 'package:graduation_project/features/company_portal/presentation/screens/company_bookmarks_page.dart';
import 'package:graduation_project/features/company_portal/presentation/screens/company_qr_page.dart';

import 'package:graduation_project/features/company_portal/presentation/screens/company_search_page.dart';
import 'package:graduation_project/features/company_portal/presentation/screens/company_settings_page.dart';
import 'package:graduation_project/features/company_portal/presentation/screens/complete_company_profile_page.dart';
import 'package:graduation_project/features/company_portal/presentation/screens/payment_page.dart';

import 'package:graduation_project/features/individuals/chat/presentation/pages/chats_tab.dart';
import 'package:graduation_project/features/individuals/features/basic_information/presentation/pages/basic_info_page.dart';
import 'package:graduation_project/features/individuals/insights/presentation/pages/insights_tab.dart';
import 'package:graduation_project/features/individuals/profile/presentation/cubit/profile_cubit.dart';
import 'package:graduation_project/features/individuals/profile/presentation/pages/profile_tab.dart';
import 'package:graduation_project/features/temp/dashboard.dart';
import 'package:graduation_project/features/individuals/navigation/pages/individuals_home_page.dart';

import 'package:graduation_project/features/auth/presentation/pages/login_page.dart';
import 'package:graduation_project/features/auth/presentation/pages/signup_page.dart';
import 'package:graduation_project/features/auth/presentation/pages/otp_verification_page.dart';

import 'package:flutter/material.dart';

// keep it here for now
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final getIt = GetIt.instance;

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
            BlocProvider(create: (context) => UserCubit()),
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
                  builder: (context, state) => BasicInfoPage(),
                ),
                // GoRoute(
                //   path: 'work-experience',
                //   parentNavigatorKey: _rootNavigatorKey,
                //   builder: (context, state) => const WorkExperiencePage(),
                // ),
              ],
            ),
          ],
        ),
      ],
    ),
    // -------------------- COMPANY PORTAL FLOW --------------------
    GoRoute(
      path: '/company/complete-profile',
      name: 'company-complete-profile',
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<CompanyBloc>(),
        child: const CompleteCompanyProfilePage(),
      ),
    ),
    GoRoute(
      path: '/company/payment',
      name: 'company-payment',
      builder: (context, state) => const PaymentPage(),
    ),
    GoRoute(
      path: '/company/search',
      name: 'company-search',
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<CompanyBloc>(),
        child: const CompanySearchPage(),
      ),
      routes: [
        GoRoute(
          path: 'advanced',
          name: 'company-advanced-search',
          builder: (context, state) => BlocProvider(
            create: (_) => getIt<CompanyBloc>(),
            child: const AdvancedSearchPage(),
          ),
        ),
        GoRoute(
          path: '/company/qr',
          name: 'company-qr',
          builder: (context, state) => BlocProvider(
            create: (_) => getIt<CompanyBloc>(),
            child: const CompanyQRScannerPage(),
          ),
        ),
        GoRoute(
          path: '/company/bookmarks',
          name: 'company-bookmarks',
          builder: (context, state) => BlocProvider(
            create: (_) => getIt<CompanyBloc>(),
            child: const CompanyBookmarksPage(),
          ),
        ),

        // صفحة الإعدادات
        GoRoute(
          path: '/company/settings',
          name: 'company-settings',
          builder: (context, state) => const CompanySettingsPage(),
        ),
      ],
    ),
  ],
);
