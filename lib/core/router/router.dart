import 'package:graduation_project/core/exports/app_exports.dart';
import 'package:graduation_project/features/CRinfo/presentation/cubit/cr_info_cubit.dart';
import 'package:graduation_project/features/candidate_details/presentation/screens/candidate_profile_page.dart';
import 'package:graduation_project/features/company_bookmarks/presentation/blocs/bloc/bookmarks_bloc.dart';
import 'package:graduation_project/features/company_bookmarks/presentation/screens/company_bookmarks_page.dart';
import 'package:graduation_project/features/company_portal/presentation/screens/complete_company_profile_page.dart';
import 'package:graduation_project/features/company_search/presentation/blocs/bloc/search_bloc.dart';
import 'package:graduation_project/features/company_search/presentation/screens/candidate_results_page.dart';
import 'package:graduation_project/features/company_search/presentation/screens/company_search_page.dart';

import 'package:graduation_project/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:graduation_project/features/payment/presentation/pages/pay_page.dart';
import 'package:graduation_project/features/payment/presentation/pages/webview_page.dart';

import 'package:graduation_project/features/company_portal/presentation/screens/onboarding/company_onboarding_router_page.dart';
import 'package:graduation_project/features/company_portal/presentation/screens/onboarding/company_qr_page.dart';

import 'package:graduation_project/features/company_portal/presentation/screens/profile/company_settings_page.dart';

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

    // 1. THE ROUTER: (لم نقم بتغيير هذا، يبقى يعتمد على CompanyBloc للتحقق من الحالة)
    GoRoute(
      path: '/company/onboarding-router',
      name: 'company-onboarding-router',
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<CompanyBloc>(),
        child: const CompanyOnboardingRouterPage(),
      ),
    ),

    // 2. ONBOARDING STEP 1: (يبقى كما هو)
    GoRoute(
      path: '/company/complete-profile',
      name: 'company-complete-profile',
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<CompanyBloc>(),
        child: const CompleteCompanyProfilePage(),
      ),
    ),

    // 3. ONBOARDING STEP 2: (يبقى كما هو)
    GoRoute(
      path: '/company/payment',
      name: 'company-payment',
      builder: (context, state) {
        return BlocProvider(
          create: (context) => getIt<PaymentCubit>(),
          child: const PayPage(),
        );
      },
    ),

    // 4. MAIN SEARCH PAGE (The new Entry Point)
    GoRoute(
      path: '/company/search',
      name: 'company-search',
      builder: (context, state) => BlocProvider(
        // ✅ التغيير الأول: نستخدم SearchBloc هنا بدلاً من CompanyBloc
        create: (_) => getIt<SearchBloc>(),
        child: const CompanySearchPage(),
      ),
      routes: [
        // 4a. SEARCH RESULTS
        GoRoute(
          path: 'search-results',
          name: 'company-search-results',
          builder: (context, state) {
            // نستقبل الـ SearchBloc الذي تم تمريره من الصفحة السابقة
            final searchBloc = state.extra as SearchBloc;

            // ✅ التغيير الثاني: نستخدم MultiBlocProvider
            // 1. لنمرر حالة البحث الحالية (value)
            // 2. لننشئ BookmarksBloc جديد لكي يعمل زر الحفظ في الكروت
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(value: searchBloc),
                BlocProvider(create: (_) => getIt<BookmarksBloc>()),
              ],
              child: const CandidateResultsPage(),
            );
          },
        ),

        // 4b. CANDIDATE DETAILS
        GoRoute(
          path: 'candidate-details/:id',
          name: 'candidate-details',
          builder: (context, state) {
            final candidateId = state.pathParameters['id']!;
            // ✅ غالباً ستحتاج BookmarksBloc هنا أيضاً إذا كان هناك زر حفظ في التفاصيل
            return BlocProvider(
              create: (_) => getIt<BookmarksBloc>(),
              child: CandidateProfilePage(candidateId: candidateId),
            );
          },
        ),

        // 4c. BOOKMARKS PAGE
        GoRoute(
          path: 'bookmarks',
          name: 'company-bookmarks',
          builder: (context, state) => BlocProvider(
            // ✅ التغيير الثالث: نستخدم BookmarksBloc الخاص بهذه الميزة
            create: (_) => getIt<BookmarksBloc>(),
            child: const CompanyBookmarksPage(),
          ),
        ),

        // 4d. QR SCANNER (لم نقم بفصله، يبقى CompanyBloc)
        GoRoute(
          path: 'qr',
          name: 'company-qr',
          builder: (context, state) => BlocProvider(
            create: (_) => getIt<CompanyBloc>(),
            child: const CompanyQRScannerPage(),
          ),
        ),

        // 4e. SETTINGS (لم نقم بفصله، يبقى كما هو)
        GoRoute(
          path: 'settings',
          name: 'company-settings',
          builder: (context, state) => const CompanySettingsPage(),
        ),
        GoRoute(
          path: '/company/verify-cr',
          name: 'verify-cr',
          builder: (context, state) => const CrInfoPage(),
        ),
      ],
    ),
    //▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲ ROUTE END ▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼
    //
  ],
);
