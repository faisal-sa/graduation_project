import 'package:graduation_project/core/exports/app_exports.dart';
import 'package:graduation_project/features/CRinfo/presentation/cubit/cr_info_cubit.dart';

import 'package:graduation_project/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:graduation_project/features/payment/presentation/pages/pay_page.dart';
import 'package:graduation_project/features/payment/presentation/pages/webview_page.dart';

import 'package:graduation_project/features/company_portal/presentation/screens/CandidateResultsPage.dart';
import 'package:graduation_project/features/company_portal/presentation/screens/company_bookmarks_page.dart';
import 'package:graduation_project/features/company_portal/presentation/screens/company_onboarding_router_page.dart';
import 'package:graduation_project/features/company_portal/presentation/screens/company_qr_page.dart';

import 'package:graduation_project/features/company_portal/presentation/screens/company_search_page.dart';
import 'package:graduation_project/features/company_portal/presentation/screens/company_settings_page.dart';
import 'package:graduation_project/features/company_portal/presentation/screens/complete_company_profile_page.dart';
import 'package:graduation_project/features/company_portal/presentation/screens/payment_page.dart';





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
    //▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲ ROUTE START ▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼
    //

    // ==================  Pay Page  =================== //
    //
    GoRoute(
      path: '/pay',
      builder: (context, state) => BlocProvider(
        create: (_) => serviceLocator<PaymentCubit>(),
        child: const PayPage(),
      ),
    ),

    // ==================  Payment WebView (3DS Authentication)  =================== //
    //
    GoRoute(
      path: '/payment-webview',
      builder: (context, state) {
        final url = state.uri.queryParameters['url'] ?? '';
        return PaymentWebViewPage(url: url);
      },
    ),

    // ==================  CR Info Page  =================== //
    //
    GoRoute(
      path: '/cr-info',
      builder: (context, state) => BlocProvider(
        create: (_) => serviceLocator<CrInfoCubit>(),
        child: const CrInfoPage(),
      ),
    ),

    // ==================  Auth Routes  =================== //
    //
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
                          create: (context) =>
                              serviceLocator.get<BasicInfoCubit>(),
                        ),
                      ],
                      child: BasicInfoPage(),
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
                GoRoute(
                  path: 'experience',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    return BlocProvider(
                      create: (context) =>
                          serviceLocator.get<WorkExperienceCubit>(),
                      child: const WorkExperienceListPage(),
                    );
                  },
                ),
                GoRoute(
                  path: 'education',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    return BlocProvider(
                      create: (context) =>
                          serviceLocator.get<EducationCubit>()
                            ..loadEducations(),
                      child: const EducationPage(),
                    );
                  },
                ),
                GoRoute(
                  path: 'certification',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    return BlocProvider(
                      create: (context) =>
                          serviceLocator.get<CertificationCubit>()
                            ..loadCertifications(),
                      child: const CertificationPage(),
                    );
                  },
                ),
                GoRoute(
                  path: 'skills',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    return const SkillsPage();
                  },
                ),
                GoRoute(
                  path: 'preferences',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    return const JobPreferencesPage();
                  },
                ),
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
        // 4a. PROFILE COMPLETION (Mandatory) - First step after login
        GoRoute(
          path: 'search-results',
          name: 'company-search-results',
          builder: (context, state) {
            final bloc = state.extra as CompanyBloc;
            return BlocProvider.value(
              value: bloc,
              child: const CandidateResultsPage(),
            );
          },
        ),
        GoRoute(
          path: 'bookmarks',
          name: 'company-bookmarks',
          builder: (context, state) => BlocProvider(
            create: (_) => getIt<CompanyBloc>(),
            child: const CompanyBookmarksPage(),
          ),
        ),

        GoRoute(
          path: 'qr',
          name: 'company-qr',
          builder: (context, state) => BlocProvider(
            create: (_) => getIt<CompanyBloc>(),
            child: const CompanyQRScannerPage(),
          ),
        ),
        GoRoute(
          path: 'settings',
          name: 'company-settings',
          builder: (context, state) => const CompanySettingsPage(),
        ),
      ],
    ),

    //▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲ ROUTE END ▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼
    //
  ],
);
