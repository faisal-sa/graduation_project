import 'package:firebase_ai/firebase_ai.dart';
import 'package:graduation_project/core/exports/app_exports.dart';
import 'package:graduation_project/features/CRinfo/presentation/cubit/cr_info_cubit.dart';
import 'package:graduation_project/features/auth/presentation/pages/auth_head.dart';
import 'package:graduation_project/features/auth/presentation/pages/new_password_page.dart';
import 'package:graduation_project/features/auth/presentation/pages/rest_passord_page.dart';
import 'package:graduation_project/features/candidate_details/presentation/screens/candidate_profile_page.dart';
import 'package:graduation_project/features/company_bookmarks/presentation/blocs/bloc/bookmarks_bloc.dart';
import 'package:graduation_project/features/company_bookmarks/presentation/screens/company_bookmarks_page.dart';
import 'package:graduation_project/features/company_portal/presentation/screens/complete_company_profile_page.dart';
import 'package:graduation_project/features/company_portal/presentation/screens/onboarding/company_onboarding_router_page.dart';
import 'package:graduation_project/features/company_portal/presentation/screens/onboarding/company_qr_page.dart';
import 'package:graduation_project/features/company_portal/presentation/screens/profile/company_settings_page.dart';
import 'package:graduation_project/features/company_search/presentation/blocs/bloc/search_bloc.dart';
import 'package:graduation_project/features/company_search/presentation/screens/candidate_results_page.dart';
import 'package:graduation_project/features/company_search/presentation/screens/company_search_page.dart';
import 'package:graduation_project/features/individuals/AI_quiz/pages/ai_skill_check_page.dart';
import 'package:graduation_project/features/individuals/profile/routes/job_preferences/presentation/cubit/job_preferences_cubit.dart';
import 'package:graduation_project/features/individuals/profile/routes/skills_languages/presentation/cubit/skills_languages_cubit.dart';
import 'package:graduation_project/features/individuals/match_strength/cubit/match_strength_cubit.dart';
import 'package:graduation_project/features/individuals/match_strength/pages/match_strength_page.dart';
import 'package:graduation_project/features/onbording/intro_page.dart';

import 'package:graduation_project/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:graduation_project/features/payment/presentation/pages/pay_page.dart';
import 'package:graduation_project/features/payment/presentation/pages/webview_page.dart';
import 'package:graduation_project/features/splash_screen/splash_screen.dart';

// keep it here for now
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final getIt = GetIt.instance;

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/otp-verification',
  routes: [
    GoRoute(path: '/auth', builder: (context, state) => const AuthHead()),
    GoRoute(
      path: '/reset-password',
      builder: (context, state) => ResetPasswordPage(),
    ),
    GoRoute(
      path: '/new-password',
      builder: (context, state) => const NewPasswordPage(),
    ),
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/intro', builder: (context, state) => const IntroPage()),

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
              routes: [
                // --- ADD THIS ROUTE ---
                GoRoute(
                  path:
                      'match-strength', // route will be /insights/match-strength
                  parentNavigatorKey: _rootNavigatorKey, // Hides bottom navbar
                  builder: (context, state) {
                    final userCubit = serviceLocator.get<UserCubit>();
                    final currentUser = userCubit.state.user;

                    return BlocProvider(
                      create: (context) {
                        final cubit = MatchStrengthCubit(
                          model: serviceLocator.get<GenerativeModel>(),
                        );
                        cubit.analyzeProfile(currentUser);
                        return cubit;
                      },
                      child: MatchStrengthPage(
                        jobTitle: currentUser.jobTitle,
                        userEntity: currentUser,
                      ),
                    );
                  },
                ),
                GoRoute(
                  path: 'ai-skill-check',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    final userCubit = serviceLocator.get<UserCubit>();
                    final currentUser = userCubit.state.user;

                    return AiSkillCheckPage(user: currentUser);
                  },
                ),
              ],
            ),
          ],
        ),

        // StatefulShellBranch(
        //   routes: [
        //     GoRoute(
        //       path: '/chats',
        //       builder: (context, state) => const ChatsTab(),
        //     ),
        //   ],
        // ),
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
                    final userCubit = serviceLocator.get<UserCubit>();
                    final initialExperiences =
                        userCubit.state.user.workExperiences;

                    return BlocProvider(
                      create: (context) {
                        final cubit = serviceLocator.get<WorkExperienceCubit>();

                        cubit.initialize(initialExperiences);

                        return cubit;
                      },
                      child: const WorkExperienceListPage(),
                    );
                  },
                ),
                GoRoute(
                  path: 'education',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    final userCubit = serviceLocator.get<UserCubit>();
                    final initialEducations = userCubit.state.user.educations;

                    return BlocProvider(
                      create: (context) {
                        final cubit = serviceLocator.get<EducationCubit>();
                        cubit.initialize(initialEducations);
                        return cubit;
                      },
                      child: const EducationPage(),
                    );
                  },
                ),
                GoRoute(
                  path: 'certification',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    // 1. Get UserCubit
                    final userCubit = serviceLocator.get<UserCubit>();
                    // 2. Extract existing certifications from UserEntity
                    final initialCertifications =
                        userCubit.state.user.certifications;

                    return BlocProvider(
                      create: (context) {
                        final cubit = serviceLocator.get<CertificationCubit>();
                        // 3. Initialize Cubit with local data instead of calling loadCertifications()
                        cubit.initialize(initialCertifications);
                        return cubit;
                      },
                      child: const CertificationPage(),
                    );
                  },
                ),
                GoRoute(
                  path: 'skills',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    // 1. Get UserCubit instance
                    final userCubit = serviceLocator.get<UserCubit>();

                    // 2. Extract existing lists for initialization
                    final initialSkills = userCubit.state.user.skills;
                    final initialLanguages = userCubit.state.user.languages;

                    // 3. Use MultiBlocProvider to provide BOTH UserCubit and SkillsLanguagesCubit
                    return MultiBlocProvider(
                      providers: [
                        // Provide the existing UserCubit to the new route context
                        BlocProvider.value(value: userCubit),
                        // Create and provide the SkillsLanguagesCubit
                        BlocProvider(
                          create: (context) {
                            final cubit = serviceLocator
                                .get<SkillsLanguagesCubit>();
                            cubit.initialize(initialSkills, initialLanguages);
                            return cubit;
                          },
                        ),
                      ],
                      child: const SkillsPage(),
                    );
                  },
                ),
                GoRoute(
                  path: 'preferences',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    // 1. Get existing UserCubit
                    final userCubit = serviceLocator.get<UserCubit>();

                    // 2. Extract current preferences from local state
                    final initialPreferences =
                        userCubit.state.user.jobPreferences;

                    // 3. Provide both cubits
                    return MultiBlocProvider(
                      providers: [
                        // Pass the UserCubit down (for the BlocListener to work)
                        BlocProvider.value(value: userCubit),

                        // Create JobPreferencesCubit and initialize with local data
                        BlocProvider(
                          create: (context) {
                            final cubit = serviceLocator
                                .get<JobPreferencesCubit>();
                            // Initialize immediately with data from UserEntity
                            cubit.initialize(initialPreferences);
                            return cubit;
                          },
                        ),
                      ],
                      child: const JobPreferencesPage(),
                    );
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
      path: '/company/onboarding-router',
      name: 'company-onboarding-router',
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<CompanyBloc>(),
        child: const CompanyOnboardingRouterPage(),
      ),
    ),

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
      builder: (context, state) {
        return BlocProvider(
          create: (context) => getIt<PaymentCubit>(),
          child: const PayPage(),
        );
      },
    ),

    GoRoute(
      path: '/company/search',
      name: 'company-search',
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<SearchBloc>(),
        child: const CompanySearchPage(),
      ),
      routes: [
        // 4a. SEARCH RESULTS
        GoRoute(
          path: 'search-results',
          name: 'company-search-results',
          builder: (context, state) {
            final searchBloc = state.extra as SearchBloc;

            return MultiBlocProvider(
              providers: [
                BlocProvider.value(value: searchBloc),
                BlocProvider(create: (_) => getIt<BookmarksBloc>()),
              ],
              child: const CandidateResultsPage(),
            );
          },
        ),

        GoRoute(
          path: 'candidate-details/:id',
          name: 'candidate-details',
          builder: (context, state) {
            final candidateId = state.pathParameters['id']!;
            return BlocProvider(
              create: (_) => getIt<BookmarksBloc>(),
              child: CandidateProfilePage(candidateId: candidateId),
            );
          },
        ),

        GoRoute(
          path: 'bookmarks',
          name: 'company-bookmarks',
          builder: (context, state) => BlocProvider(
            create: (_) => getIt<BookmarksBloc>(),
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
