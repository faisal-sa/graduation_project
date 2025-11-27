import 'package:graduation_project/core/exports/app_exports.dart';

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
