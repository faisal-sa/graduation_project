// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_ai/firebase_ai.dart' as _i187;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

import '../../features/ai_analysis/data/data_sources/ai_analysis_data_source.dart'
    as _i1065;
import '../../features/ai_analysis/data/data_sources/ai_local_data_source.dart'
    as _i32;
import '../../features/ai_analysis/data/repositories/ai_analysis_repository_impl.dart'
    as _i944;
import '../../features/ai_analysis/domain/repositories/ai_analysis_repository.dart'
    as _i497;
import '../../features/ai_analysis/presentation/cubit/ai_analysis_cubit.dart'
    as _i335;
import '../../features/auth/data/datasources/auth_remote_datasource.dart'
    as _i161;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/usecases/get_current_user.dart' as _i111;
import '../../features/auth/domain/usecases/login.dart' as _i428;
import '../../features/auth/domain/usecases/resend_otp.dart' as _i152;
import '../../features/auth/domain/usecases/reset_password.dart' as _i1066;
import '../../features/auth/domain/usecases/send_otp.dart' as _i727;
import '../../features/auth/domain/usecases/send_password_reset_otp.dart'
    as _i665;
import '../../features/auth/domain/usecases/sign_out.dart' as _i568;
import '../../features/auth/domain/usecases/sign_up.dart' as _i190;
import '../../features/auth/domain/usecases/update_password.dart' as _i455;
import '../../features/auth/domain/usecases/verify_otp.dart' as _i975;
import '../../features/auth/domain/usecases/verify_password_reset_otp.dart'
    as _i500;
import '../../features/auth/presentation/cubit/auth_cubit.dart' as _i117;
import '../../features/candidate_details/data/data_sources/candidate_details_data_source.dart'
    as _i149;
import '../../features/candidate_details/data/repositories/candidate_details_repository_impl.dart'
    as _i265;
import '../../features/candidate_details/domain/repositories/candidate_details_repository.dart'
    as _i309;
import '../../features/candidate_details/domain/usecases/get_candidate_profile_usecase.dart'
    as _i57;
import '../../features/candidate_details/domain/usecases/unlock_candidate_usecase.dart'
    as _i322;
import '../../features/candidate_details/presentation/cubit/candidate_details_cubit.dart'
    as _i1061;
import '../../features/company_bookmarks/data/data_sources/company_bookmarks_data_source.dart'
    as _i626;
import '../../features/company_bookmarks/data/repositories/company_bookmarks_repository_impl.dart'
    as _i269;
import '../../features/company_bookmarks/domain/repositories/company_bookmarks_repository.dart'
    as _i731;
import '../../features/company_bookmarks/domain/usecases/add_candidate_bookmark.dart'
    as _i476;
import '../../features/company_bookmarks/domain/usecases/get_company_bookmarks.dart'
    as _i814;
import '../../features/company_bookmarks/domain/usecases/remove_candidate_bookmark.dart'
    as _i513;
import '../../features/company_bookmarks/presentation/blocs/bloc/bookmarks_bloc.dart'
    as _i916;
import '../../features/company_portal/data/data_sources/company_portal_data_source.dart'
    as _i252;
import '../../features/company_portal/data/repositories/company_portal_repository_impl.dart'
    as _i624;
import '../../features/company_portal/domain/repositories/company_portal_repository.dart'
    as _i786;
import '../../features/company_portal/domain/usecases/check_company_status.dart'
    as _i528;
import '../../features/company_portal/domain/usecases/get_company_profile.dart'
    as _i303;
import '../../features/company_portal/domain/usecases/register_company.dart'
    as _i468;
import '../../features/company_portal/domain/usecases/update_company_profile.dart'
    as _i923;
import '../../features/company_portal/domain/usecases/verify_company_qr.dart'
    as _i742;
import '../../features/company_portal/presentation/blocs/bloc/company_bloc.dart'
    as _i401;
import '../../features/company_search/data/data_sources/company_search_data_source.dart'
    as _i7;
import '../../features/company_search/data/repositories/company_search_repository_impl.dart'
    as _i1065;
import '../../features/company_search/domain/repositories/company_search_repository.dart'
    as _i104;
import '../../features/company_search/domain/usecases/search_candidates.dart'
    as _i979;
import '../../features/company_search/presentation/blocs/bloc/search_bloc.dart'
    as _i214;
import '../../features/CRinfo/data/datasources/wathq_remote_datasource.dart'
    as _i697;
import '../../features/CRinfo/data/repositories/cr_info_repository_impl.dart'
    as _i319;
import '../../features/CRinfo/domain/repositories/cr_info_repository.dart'
    as _i861;
import '../../features/CRinfo/domain/usecases/get_cr_info.dart' as _i333;
import '../../features/CRinfo/presentation/cubit/cr_info_cubit.dart' as _i550;
import '../../features/individuals/match_strength/cubit/match_strength_cubit.dart'
    as _i406;
import '../../features/individuals/profile/routes/about_me/data/datasources/about_me_remote_data_source.dart'
    as _i950;
import '../../features/individuals/profile/routes/about_me/data/repositories/about_me_repository_impl.dart'
    as _i506;
import '../../features/individuals/profile/routes/about_me/domain/repositories/about_me_repository.dart'
    as _i1046;
import '../../features/individuals/profile/routes/about_me/domain/usecases/delete_about_me_video_use_case.dart'
    as _i945;
import '../../features/individuals/profile/routes/about_me/domain/usecases/save_about_me_use_case.dart'
    as _i689;
import '../../features/individuals/profile/routes/about_me/presentation/cubit/about_me_cubit.dart'
    as _i661;
import '../../features/individuals/profile/routes/basic_info/data/datasources/basic_info_remote_data_source.dart'
    as _i166;
import '../../features/individuals/profile/routes/basic_info/data/repositories/basic_info_repository_impl.dart'
    as _i720;
import '../../features/individuals/profile/routes/basic_info/domain/repositories/basic_info_repository.dart'
    as _i216;
import '../../features/individuals/profile/routes/basic_info/domain/usecases/save_basic_info_usecase.dart'
    as _i700;
import '../../features/individuals/profile/routes/basic_info/presentation/cubit/basic_info_cubit.dart'
    as _i170;
import '../../features/individuals/profile/routes/certifications/data/datasources/certification_remote_data_source.dart'
    as _i513;
import '../../features/individuals/profile/routes/certifications/data/repositories/certification_repository_impl.dart'
    as _i119;
import '../../features/individuals/profile/routes/certifications/domain/repositories/certification_repository.dart'
    as _i439;
import '../../features/individuals/profile/routes/certifications/domain/usecases/add_certification_usecase.dart'
    as _i3;
import '../../features/individuals/profile/routes/certifications/domain/usecases/delete_certification_usecase.dart'
    as _i1063;
import '../../features/individuals/profile/routes/certifications/domain/usecases/get_certifications_usecase.dart'
    as _i603;
import '../../features/individuals/profile/routes/certifications/domain/usecases/update_certification_usecase.dart'
    as _i973;
import '../../features/individuals/profile/routes/certifications/presentation/cubit/certification_cubit.dart'
    as _i516;
import '../../features/individuals/profile/routes/education/data/datasources/education_remote_data_source.dart'
    as _i31;
import '../../features/individuals/profile/routes/education/data/repositories/education_repository_impl.dart'
    as _i9;
import '../../features/individuals/profile/routes/education/domain/repositories/education_repository.dart'
    as _i916;
import '../../features/individuals/profile/routes/education/domain/usecases/add_education_usecase.dart'
    as _i33;
import '../../features/individuals/profile/routes/education/domain/usecases/delete_education_usecase.dart'
    as _i302;
import '../../features/individuals/profile/routes/education/domain/usecases/get_educations_usecase.dart'
    as _i871;
import '../../features/individuals/profile/routes/education/domain/usecases/update_education_usecase.dart'
    as _i117;
import '../../features/individuals/profile/routes/education/presentation/cubit/education_cubit.dart'
    as _i372;
import '../../features/individuals/profile/routes/job_preferences/data/datasources/job_preferences_remote_datasource.dart'
    as _i281;
import '../../features/individuals/profile/routes/job_preferences/data/repositories/job_preferences_repository_impl.dart'
    as _i262;
import '../../features/individuals/profile/routes/job_preferences/domain/repositories/job_preferences_repository.dart'
    as _i570;
import '../../features/individuals/profile/routes/job_preferences/domain/usecases/get_job_preferences_usecase.dart'
    as _i39;
import '../../features/individuals/profile/routes/job_preferences/domain/usecases/update_job_preferences_usecase.dart'
    as _i565;
import '../../features/individuals/profile/routes/job_preferences/presentation/cubit/job_preferences_cubit.dart'
    as _i3;
import '../../features/individuals/profile/routes/skills_languages/data/datasources/skills_languages_remote_data_source.dart'
    as _i377;
import '../../features/individuals/profile/routes/skills_languages/data/repositories/skills_language_repo_impl.dart'
    as _i693;
import '../../features/individuals/profile/routes/skills_languages/domain/repositories/skills_languages_repository.dart'
    as _i736;
import '../../features/individuals/profile/routes/skills_languages/presentation/cubit/skills_languages_cubit.dart'
    as _i758;
import '../../features/individuals/profile/routes/work_experience/data/datasources/work_experience_remote_data_source.dart'
    as _i1005;
import '../../features/individuals/profile/routes/work_experience/data/repositories/work_experience_repository_impl.dart'
    as _i902;
import '../../features/individuals/profile/routes/work_experience/domain/repositories/work_experience_repository.dart'
    as _i757;
import '../../features/individuals/profile/routes/work_experience/domain/usecases/add_work_experience_usecase.dart'
    as _i718;
import '../../features/individuals/profile/routes/work_experience/domain/usecases/delete_work_experience_usecase.dart'
    as _i989;
import '../../features/individuals/profile/routes/work_experience/domain/usecases/get_work_experiences_usecase.dart'
    as _i894;
import '../../features/individuals/profile/routes/work_experience/domain/usecases/update_work_experience_usecase.dart'
    as _i1033;
import '../../features/individuals/profile/routes/work_experience/presentation/cubit/work_experience_cubit.dart'
    as _i906;
import '../../features/individuals/shared/user/data/datasources/AI_datasource.dart'
    as _i441;
import '../../features/individuals/shared/user/data/datasources/user_local_datasource.dart'
    as _i706;
import '../../features/individuals/shared/user/data/datasources/user_remote_datasource.dart'
    as _i83;
import '../../features/individuals/shared/user/data/repositories/user_repository_impl.dart'
    as _i468;
import '../../features/individuals/shared/user/domain/repositories/user_repository.dart'
    as _i369;
import '../../features/individuals/shared/user/domain/usecases/cache_user.dart'
    as _i736;
import '../../features/individuals/shared/user/domain/usecases/fetch_user_profile.dart'
    as _i54;
import '../../features/individuals/shared/user/domain/usecases/get_cached_user.dart'
    as _i188;
import '../../features/individuals/shared/user/domain/usecases/parse_resume_with_ai.dart'
    as _i188;
import '../../features/individuals/shared/user/domain/usecases/sync_user_to_remote.dart'
    as _i318;
import '../../features/individuals/shared/user/domain/usecases/update_user.dart'
    as _i939;
import '../../features/individuals/shared/user/presentation/cubit/user_cubit.dart'
    as _i792;
import '../../features/payment/data/datasources/payment_remote_data_source.dart'
    as _i811;
import '../../features/payment/data/repositories/payment_repository_impl.dart'
    as _i265;
import '../../features/payment/domain/usecases/process_payment_usecase.dart'
    as _i432;
import '../../features/payment/export_payment.dart' as _i903;
import '../../features/payment/presentation/cubit/payment_cubit.dart' as _i513;
import '../env_config/env_config.dart' as _i113;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i454.SupabaseClient>(
      () => registerModule.supabaseClient,
      preResolve: true,
    );
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.singleton<_i32.AiLocalDataSource>(() => _i32.AiLocalDataSource());
    gh.lazySingleton<_i187.GenerativeModel>(
      () => registerModule.generativeModel,
    );
    gh.lazySingleton<_i1065.AiRemoteDataSource>(
      () => _i1065.AiRemoteDataSource(),
    );
    gh.factory<_i706.UserLocalDataSource>(
      () => _i706.UserLocalDataSource(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i950.AboutMeRemoteDataSource>(
      () => _i950.AboutMeRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i31.EducationRemoteDataSource>(
      () => _i31.EducationRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i149.CandidateRemoteDataSource>(
      () => _i149.CandidateRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i626.BookmarksRemoteDataSource>(
      () => _i626.BookmarksRemoteDataSource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i252.CompanyRemoteDataSource>(
      () => _i252.CompanyRemoteDataSource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i7.SearchRemoteDataSource>(
      () => _i7.SearchRemoteDataSource(gh<_i454.SupabaseClient>()),
    );
    gh.factory<_i83.UserRemoteDataSource>(
      () => _i83.UserRemoteDataSource(gh<_i454.SupabaseClient>()),
    );
    gh.factory<_i441.AIDataSource>(
      () => _i441.AIDataSource(gh<_i187.GenerativeModel>()),
    );
    gh.lazySingleton<_i309.CandidateRepository>(
      () =>
          _i265.CandidateRepositoryImpl(gh<_i149.CandidateRemoteDataSource>()),
    );
    gh.lazySingleton<_i811.PaymentRemoteDataSource>(
      () => _i811.PaymentRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i697.WathqRemoteDataSource>(
      () => _i697.WathqRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i861.CrInfoRepository>(
      () => _i319.CrInfoRepositoryImpl(gh<_i697.WathqRemoteDataSource>()),
    );
    gh.lazySingleton<_i369.UserRepository>(
      () => _i468.UserRepositoryImpl(
        remoteDataSource: gh<_i83.UserRemoteDataSource>(),
        localDataSource: gh<_i706.UserLocalDataSource>(),
        aiDataSource: gh<_i441.AIDataSource>(),
      ),
    );
    gh.lazySingleton<_i281.JobPreferencesRemoteDataSource>(
      () =>
          _i281.JobPreferencesRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i161.AuthRemoteDataSource>(
      () => _i161.AuthRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.factory<_i406.MatchStrengthCubit>(
      () => _i406.MatchStrengthCubit(model: gh<_i187.GenerativeModel>()),
    );
    gh.factory<_i57.GetCandidateProfileUseCase>(
      () => _i57.GetCandidateProfileUseCase(gh<_i309.CandidateRepository>()),
    );
    gh.factory<_i322.UnlockCandidateUseCase>(
      () => _i322.UnlockCandidateUseCase(gh<_i309.CandidateRepository>()),
    );
    gh.factory<_i1061.CandidateProfileCubit>(
      () => _i1061.CandidateProfileCubit(gh<_i309.CandidateRepository>()),
    );
    gh.lazySingleton<_i513.CertificationRemoteDataSource>(
      () => _i513.CertificationRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.factory<_i333.GetCrInfo>(
      () => _i333.GetCrInfo(gh<_i861.CrInfoRepository>()),
    );
    gh.lazySingleton<_i916.EducationRepository>(
      () => _i9.EducationRepositoryImpl(gh<_i31.EducationRemoteDataSource>()),
    );
    gh.lazySingleton<_i1046.AboutMeRepository>(
      () => _i506.AboutMeRepositoryImpl(
        gh<_i950.AboutMeRemoteDataSource>(),
        gh<_i454.SupabaseClient>(),
      ),
    );
    gh.factory<_i497.AiRepository>(
      () => _i944.AiRepositoryImpl(
        gh<_i1065.AiRemoteDataSource>(),
        gh<_i32.AiLocalDataSource>(),
      ),
    );
    gh.factory<_i736.CacheUser>(
      () => _i736.CacheUser(gh<_i369.UserRepository>()),
    );
    gh.factory<_i54.FetchUserProfile>(
      () => _i54.FetchUserProfile(gh<_i369.UserRepository>()),
    );
    gh.factory<_i188.GetCachedUser>(
      () => _i188.GetCachedUser(gh<_i369.UserRepository>()),
    );
    gh.factory<_i188.ParseResumeWithAI>(
      () => _i188.ParseResumeWithAI(gh<_i369.UserRepository>()),
    );
    gh.factory<_i318.SyncUserToRemote>(
      () => _i318.SyncUserToRemote(gh<_i369.UserRepository>()),
    );
    gh.factory<_i939.UpdateUser>(
      () => _i939.UpdateUser(gh<_i369.UserRepository>()),
    );
    gh.lazySingleton<_i377.SkillsLanguagesRemoteDataSource>(
      () =>
          _i377.SkillsLanguagesRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i166.BasicInfoRemoteDataSource>(
      () => _i166.BasicInfoRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.factory<_i104.SearchRepository>(
      () => _i1065.SearchRepositoryImpl(gh<_i7.SearchRemoteDataSource>()),
    );
    gh.lazySingleton<_i1005.WorkExperienceRemoteDataSource>(
      () =>
          _i1005.WorkExperienceRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i792.UserCubit>(
      () => _i792.UserCubit(
        gh<_i188.GetCachedUser>(),
        gh<_i736.CacheUser>(),
        gh<_i54.FetchUserProfile>(),
        gh<_i188.ParseResumeWithAI>(),
        gh<_i454.SupabaseClient>(),
      ),
    );
    gh.lazySingleton<_i33.AddEducationUseCase>(
      () => _i33.AddEducationUseCase(gh<_i916.EducationRepository>()),
    );
    gh.lazySingleton<_i302.DeleteEducationUseCase>(
      () => _i302.DeleteEducationUseCase(gh<_i916.EducationRepository>()),
    );
    gh.lazySingleton<_i871.GetEducationsUseCase>(
      () => _i871.GetEducationsUseCase(gh<_i916.EducationRepository>()),
    );
    gh.lazySingleton<_i117.UpdateEducationUseCase>(
      () => _i117.UpdateEducationUseCase(gh<_i916.EducationRepository>()),
    );
    gh.factory<_i731.BookmarksRepository>(
      () =>
          _i269.BookmarksRepositoryImpl(gh<_i626.BookmarksRemoteDataSource>()),
    );
    gh.factory<_i786.CompanyRepository>(
      () => _i624.CompanyRepositoryImpl(gh<_i252.CompanyRemoteDataSource>()),
    );
    gh.lazySingleton<_i570.JobPreferencesRepository>(
      () => _i262.JobPreferencesRepositoryImpl(
        gh<_i281.JobPreferencesRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i787.AuthRepository>(
      () => _i153.AuthRepositoryImpl(gh<_i161.AuthRemoteDataSource>()),
    );
    gh.lazySingleton<_i903.PaymentRepository>(
      () => _i265.PaymentRepositoryImpl(gh<_i903.PaymentRemoteDataSource>()),
    );
    gh.factory<_i468.RegisterCompany>(
      () => _i468.RegisterCompany(gh<_i786.CompanyRepository>()),
    );
    gh.factory<_i742.VerifyCompanyQR>(
      () => _i742.VerifyCompanyQR(gh<_i786.CompanyRepository>()),
    );
    gh.lazySingleton<_i757.WorkExperienceRepository>(
      () => _i902.WorkExperienceRepositoryImpl(
        gh<_i1005.WorkExperienceRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i736.SkillsLanguagesRepository>(
      () => _i693.SkillsLanguagesRepositoryImpl(
        gh<_i377.SkillsLanguagesRemoteDataSource>(),
      ),
    );
    gh.factory<_i528.CheckCompanyStatus>(
      () => _i528.CheckCompanyStatus(gh<_i786.CompanyRepository>()),
    );
    gh.factory<_i303.GetCompanyProfile>(
      () => _i303.GetCompanyProfile(gh<_i786.CompanyRepository>()),
    );
    gh.factory<_i923.UpdateCompanyProfile>(
      () => _i923.UpdateCompanyProfile(gh<_i786.CompanyRepository>()),
    );
    gh.lazySingleton<_i216.BasicInfoRepository>(
      () =>
          _i720.BasicInfoRepositoryImpl(gh<_i166.BasicInfoRemoteDataSource>()),
    );
    gh.lazySingleton<_i439.CertificationRepository>(
      () => _i119.CertificationRepositoryImpl(
        gh<_i513.CertificationRemoteDataSource>(),
        gh<_i454.SupabaseClient>(),
      ),
    );
    gh.factory<_i335.AiAnalysisCubit>(
      () => _i335.AiAnalysisCubit(gh<_i497.AiRepository>()),
    );
    gh.lazySingleton<_i432.ProcessPaymentUseCase>(
      () => _i432.ProcessPaymentUseCase(gh<_i903.PaymentRepository>()),
    );
    gh.factory<_i550.CrInfoCubit>(
      () => _i550.CrInfoCubit(getCrInfo: gh<_i333.GetCrInfo>()),
    );
    gh.lazySingleton<_i39.GetJobPreferencesUseCase>(
      () => _i39.GetJobPreferencesUseCase(gh<_i570.JobPreferencesRepository>()),
    );
    gh.lazySingleton<_i565.UpdateJobPreferencesUseCase>(
      () => _i565.UpdateJobPreferencesUseCase(
        gh<_i570.JobPreferencesRepository>(),
      ),
    );
    gh.lazySingleton<_i700.SaveBasicInfoUseCase>(
      () => _i700.SaveBasicInfoUseCase(gh<_i216.BasicInfoRepository>()),
    );
    gh.lazySingleton<_i979.SearchCandidatesUseCase>(
      () => _i979.SearchCandidatesUseCase(gh<_i104.SearchRepository>()),
    );
    gh.lazySingleton<_i945.DeleteAboutMeVideoUseCase>(
      () => _i945.DeleteAboutMeVideoUseCase(gh<_i1046.AboutMeRepository>()),
    );
    gh.lazySingleton<_i689.SaveAboutMeUseCase>(
      () => _i689.SaveAboutMeUseCase(gh<_i1046.AboutMeRepository>()),
    );
    gh.lazySingleton<_i814.GetBookmarksUseCase>(
      () => _i814.GetBookmarksUseCase(gh<_i731.BookmarksRepository>()),
    );
    gh.lazySingleton<_i513.RemoveBookmarkUseCase>(
      () => _i513.RemoveBookmarkUseCase(gh<_i731.BookmarksRepository>()),
    );
    gh.factory<_i476.AddCandidateBookmark>(
      () => _i476.AddCandidateBookmark(gh<_i731.BookmarksRepository>()),
    );
    gh.factory<_i401.CompanyBloc>(
      () => _i401.CompanyBloc(
        gh<_i303.GetCompanyProfile>(),
        gh<_i923.UpdateCompanyProfile>(),
        gh<_i528.CheckCompanyStatus>(),
        gh<_i468.RegisterCompany>(),
        gh<_i742.VerifyCompanyQR>(),
      ),
    );
    gh.factory<_i3.AddCertificationUseCase>(
      () => _i3.AddCertificationUseCase(gh<_i439.CertificationRepository>()),
    );
    gh.factory<_i1063.DeleteCertificationUseCase>(
      () => _i1063.DeleteCertificationUseCase(
        gh<_i439.CertificationRepository>(),
      ),
    );
    gh.factory<_i603.GetCertificationsUseCase>(
      () => _i603.GetCertificationsUseCase(gh<_i439.CertificationRepository>()),
    );
    gh.factory<_i973.UpdateCertificationUseCase>(
      () =>
          _i973.UpdateCertificationUseCase(gh<_i439.CertificationRepository>()),
    );
    gh.factory<_i3.JobPreferencesCubit>(
      () => _i3.JobPreferencesCubit(
        gh<_i39.GetJobPreferencesUseCase>(),
        gh<_i565.UpdateJobPreferencesUseCase>(),
      ),
    );
    gh.factory<_i372.EducationCubit>(
      () => _i372.EducationCubit(
        gh<_i871.GetEducationsUseCase>(),
        gh<_i302.DeleteEducationUseCase>(),
        gh<_i33.AddEducationUseCase>(),
        gh<_i117.UpdateEducationUseCase>(),
      ),
    );
    gh.lazySingleton<_i718.AddWorkExperienceUseCase>(
      () =>
          _i718.AddWorkExperienceUseCase(gh<_i757.WorkExperienceRepository>()),
    );
    gh.lazySingleton<_i989.DeleteWorkExperienceUseCase>(
      () => _i989.DeleteWorkExperienceUseCase(
        gh<_i757.WorkExperienceRepository>(),
      ),
    );
    gh.lazySingleton<_i894.GetWorkExperiencesUseCase>(
      () =>
          _i894.GetWorkExperiencesUseCase(gh<_i757.WorkExperienceRepository>()),
    );
    gh.lazySingleton<_i1033.UpdateWorkExperienceUseCase>(
      () => _i1033.UpdateWorkExperienceUseCase(
        gh<_i757.WorkExperienceRepository>(),
      ),
    );
    gh.factory<_i758.SkillsLanguagesCubit>(
      () => _i758.SkillsLanguagesCubit(gh<_i736.SkillsLanguagesRepository>()),
    );
    gh.factory<_i111.GetCurrentUser>(
      () => _i111.GetCurrentUser(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i428.Login>(() => _i428.Login(gh<_i787.AuthRepository>()));
    gh.factory<_i152.ResendOTP>(
      () => _i152.ResendOTP(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i1066.ResetPassword>(
      () => _i1066.ResetPassword(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i727.SendOTP>(() => _i727.SendOTP(gh<_i787.AuthRepository>()));
    gh.factory<_i665.SendPasswordResetOTP>(
      () => _i665.SendPasswordResetOTP(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i568.SignOut>(() => _i568.SignOut(gh<_i787.AuthRepository>()));
    gh.factory<_i190.SignUp>(() => _i190.SignUp(gh<_i787.AuthRepository>()));
    gh.factory<_i455.UpdatePassword>(
      () => _i455.UpdatePassword(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i975.VerifyOTP>(
      () => _i975.VerifyOTP(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i500.VerifyPasswordResetOTP>(
      () => _i500.VerifyPasswordResetOTP(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i513.PaymentCubit>(
      () => _i513.PaymentCubit(gh<_i903.ProcessPaymentUseCase>()),
    );
    gh.factory<_i661.AboutMeCubit>(
      () => _i661.AboutMeCubit(
        gh<_i689.SaveAboutMeUseCase>(),
        gh<_i945.DeleteAboutMeVideoUseCase>(),
      ),
    );
    gh.factory<_i214.SearchBloc>(
      () => _i214.SearchBloc(gh<_i979.SearchCandidatesUseCase>()),
    );
    gh.factory<_i516.CertificationCubit>(
      () => _i516.CertificationCubit(
        gh<_i603.GetCertificationsUseCase>(),
        gh<_i1063.DeleteCertificationUseCase>(),
        gh<_i3.AddCertificationUseCase>(),
        gh<_i973.UpdateCertificationUseCase>(),
      ),
    );
    gh.factory<_i170.BasicInfoCubit>(
      () => _i170.BasicInfoCubit(gh<_i700.SaveBasicInfoUseCase>()),
    );
    gh.factory<_i916.BookmarksBloc>(
      () => _i916.BookmarksBloc(
        gh<_i814.GetBookmarksUseCase>(),
        gh<_i476.AddCandidateBookmark>(),
        gh<_i513.RemoveBookmarkUseCase>(),
      ),
    );
    gh.factory<_i906.WorkExperienceCubit>(
      () => _i906.WorkExperienceCubit(
        gh<_i894.GetWorkExperiencesUseCase>(),
        gh<_i989.DeleteWorkExperienceUseCase>(),
        gh<_i718.AddWorkExperienceUseCase>(),
        gh<_i1033.UpdateWorkExperienceUseCase>(),
      ),
    );
    gh.factory<_i117.AuthCubit>(
      () => _i117.AuthCubit(
        signUp: gh<_i190.SignUp>(),
        login: gh<_i428.Login>(),
        signOut: gh<_i568.SignOut>(),
        getCurrentUser: gh<_i111.GetCurrentUser>(),
        sendOTP: gh<_i727.SendOTP>(),
        resendOTP: gh<_i152.ResendOTP>(),
        verifyOTP: gh<_i975.VerifyOTP>(),
        resetPasswordOTP: gh<_i1066.ResetPassword>(),
        sendPasswordResetOTP: gh<_i665.SendPasswordResetOTP>(),
        verifyPasswordResetOTP: gh<_i500.VerifyPasswordResetOTP>(),
        updatePassword: gh<_i455.UpdatePassword>(),
        getCrInfo: gh<_i333.GetCrInfo>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i113.RegisterModule {}
