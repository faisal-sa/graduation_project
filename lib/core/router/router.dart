import 'package:graduation_project/core/exports/app_exports.dart';
import 'package:graduation_project/features/company_portal/presentation/pages/CompanySearchPage.dart';
import 'package:graduation_project/features/company_portal/presentation/pages/advanced_searchpage.dart';
import 'package:graduation_project/features/company_portal/presentation/pages/company_qr_scanner_page.dart';
import 'package:graduation_project/features/company_portal/presentation/pages/company_settings_page.dart';
import 'package:graduation_project/features/company_portal/presentation/pages/company_status_wrapper.dart';
import 'package:graduation_project/features/company_portal/presentation/pages/complete_company_profile_page.dart';
import 'package:graduation_project/features/company_portal/presentation/pages/ompany_bookmarks_page.dart';
import 'package:graduation_project/features/company_portal/presentation/pages/payment_page.dart';

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
                GoRoute(
                  path: 'experience',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    return BlocProvider(
                      create: (context) =>
                          serviceLocator.get<WorkExperienceListCubit>()
                            ..loadExperiences(),
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
                          serviceLocator.get<EducationListCubit>()
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
                          serviceLocator.get<CertificationListCubit>()
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

    // -------------------- 4. COMPANY PORTAL FLOW --------------------
    GoRoute(
      path: '/company',
      name: 'company-root',
      builder: (context, state) {
        // Provide the CompanyBloc at the root
        return BlocProvider(
          create: (_) => serviceLocator.get<CompanyBloc>(),
          child: const CompanyStatusWrapper(), // The Gatekeeper
        );
      },
      routes: [
        // 4a. PROFILE COMPLETION (Mandatory) - First step after login
        GoRoute(
          path: 'complete-profile',
          name: 'company-complete-profile',
          builder: (context, state) => CompleteCompanyProfilePage(),
        ),

        // 4c. SEARCH HOME (Final Destination)
        GoRoute(
          path: 'search',
          name: 'company-search',
          builder: (context, state) => const CompanySearchPage(),
          routes: [
            // Nested features under the main search/home view
            GoRoute(
              path: 'advanced',
              name: 'company-advanced-search',
              builder: (context, state) => AdvancedSearchPage(),
            ),
            GoRoute(
              path: 'bookmarks',
              name: 'company-bookmarks',
              builder: (context, state) => const CompanyBookmarksPage(),
            ),
            GoRoute(
              path: 'qr-scanner',
              name: 'company-qr-scanner',
              builder: (context, state) => const CompanyQRScannerPage(),
            ),
            GoRoute(
              path: 'settings',
              name: 'company-settings',
              builder: (context, state) => const CompanySettingsPage(),
            ),
          ],
        ),
      ],
    ),
    // ==================  Pay Page  =================== //
    //
    GoRoute(
      path: '/pay',
      builder: (context, state) {
        return const PayPage();
      },
    ),
    GoRoute(
      path: '/crInfo',
      builder: (context, state) {
        return const CrInfoPage(); //spalsh later page
      },
    ),

    //▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲ ROUTE END ▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼
  ],
);
