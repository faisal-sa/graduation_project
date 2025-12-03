import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/features/company_portal/presentation/blocs/bloc/company_bloc.dart';
import 'package:graduation_project/features/company_portal/presentation/screens/advanced_searchpage.dart';
import 'package:graduation_project/features/company_portal/presentation/screens/company_onboarding_router_page.dart';
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

    // 1. THE ROUTER: Checks the status after successful login/signup
    GoRoute(
      path: '/company/onboarding-router',
      name: 'company-onboarding-router',
      // We must provide the CompanyBloc here so the router page can dispatch
      // the CheckCompanyStatusEvent and listen for the results.
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<CompanyBloc>(),
        child: const CompanyOnboardingRouterPage(),
      ),
    ),

    // 2. ONBOARDING STEP 1: Profile Completion (if profile is incomplete)
    GoRoute(
      path: '/company/complete-profile',
      name: 'company-complete-profile',
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<CompanyBloc>(),
        child: const CompleteCompanyProfilePage(),
      ),
    ),

    // 3. ONBOARDING STEP 2: Payment/Verification (if profile is complete but unverified/unpaid)
    GoRoute(
      path: '/company/payment',
      name: 'company-payment',
      builder: (context, state) => const PaymentPage(),
      // Note: This page must route to '/company/search' upon success.
    ),

    // 4. MAIN FEATURE: Search Candidates (if all prerequisites are met)
    GoRoute(
      path: '/company/search',
      name: 'company-search',
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<CompanyBloc>(),
        child: CompanySearchPage(),
      ),
      routes: [
        GoRoute(
          path: 'advanced',
          name: 'company-advanced-search',
          builder: (context, state) => BlocProvider(
            create: (_) => getIt<CompanyBloc>(),
            child: AdvancedSearchPage(),
          ),
        ),
        // Note: The QR route should ideally be nested under /company/search or accessible from it.
        // I moved the absolute path '/company/qr' to be relative to the root or explicitly defined.
        GoRoute(
          path: 'qr',
          name: 'company-qr',
          builder: (context, state) => BlocProvider(
            create: (_) => getIt<CompanyBloc>(),
            child: const CompanyQRScannerPage(),
          ),
        ),
        // GoRoute(
        //   path: 'bookmarks',
        //   name: 'company-bookmarks',
        //   builder: (context, state) => BlocProvider(
        //     create: (_) => getIt<CompanyBloc>(),
        //     child: const CompanyQRScannerPage(),
        //   ),
        // ),
        GoRoute(
          path: 'settings',
          name: 'company-settings',
          builder: (context, state) => const CompanySettingsPage(),
        ),
      ],
    ),

    // Define other common/utility routes if necessary (e.g., /settings)
  ],
  // ... rest of GoRouter configuration (errorBuilder, redirect, etc.)
);
