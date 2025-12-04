// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

import '../../features/auth/data/datasources/auth_remote_datasource.dart'
    as _i161;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/usecases/get_current_user.dart' as _i111;
import '../../features/auth/domain/usecases/login.dart' as _i428;
import '../../features/auth/domain/usecases/resend_otp.dart' as _i152;
import '../../features/auth/domain/usecases/send_otp.dart' as _i727;
import '../../features/auth/domain/usecases/sign_out.dart' as _i568;
import '../../features/auth/domain/usecases/sign_up.dart' as _i190;
import '../../features/auth/domain/usecases/verify_otp.dart' as _i975;
import '../../features/auth/presentation/cubit/auth_cubit.dart' as _i117;
import '../../features/company_portal/data/data_sources/company_portal_data_source.dart'
    as _i252;
import '../../features/company_portal/data/repositories/company_portal_repository_impl.dart'
    as _i624;
import '../../features/company_portal/domain/repositories/company_portal_repository.dart'
    as _i786;
import '../../features/company_portal/domain/usecases/add_candidate_bookmark.dart'
    as _i533;
import '../../features/company_portal/domain/usecases/check_company_status.dart'
    as _i528;
import '../../features/company_portal/domain/usecases/get_company_bookmarks.dart'
    as _i831;
import '../../features/company_portal/domain/usecases/get_company_profile.dart'
    as _i303;
import '../../features/company_portal/domain/usecases/register_company.dart'
    as _i468;
import '../../features/company_portal/domain/usecases/remove_candidate_bookmark.dart'
    as _i243;
import '../../features/company_portal/domain/usecases/search_candidates.dart'
    as _i754;
import '../../features/company_portal/domain/usecases/update_company_profile.dart'
    as _i923;
import '../../features/company_portal/domain/usecases/verify_company_qr.dart'
    as _i742;
import '../../features/company_portal/presentation/blocs/bloc/company_bloc.dart'
    as _i401;
import '../../features/CRinfo/data/datasources/wathq_remote_datasource.dart'
    as _i697;
import '../../features/CRinfo/data/repositories/cr_info_repository_impl.dart'
    as _i319;
import '../../features/CRinfo/domain/repositories/cr_info_repository.dart'
    as _i861;
import '../../features/CRinfo/domain/usecases/get_cr_info.dart' as _i333;
import '../../features/CRinfo/presentation/cubit/cr_info_cubit.dart' as _i550;
import '../../features/individuals/features/about_me/data/datasources/about_me_remote_data_source.dart'
    as _i733;
import '../../features/individuals/features/about_me/data/repositories/about_me_repository_impl.dart'
    as _i633;
import '../../features/individuals/features/about_me/domain/repositories/about_me_repository.dart'
    as _i542;
import '../../features/individuals/features/about_me/domain/usecases/delete_about_me_video_use_case.dart'
    as _i1047;
import '../../features/individuals/features/about_me/domain/usecases/save_about_me_use_case.dart'
    as _i250;
import '../../features/individuals/features/about_me/presentation/cubit/about_me_cubit.dart'
    as _i781;
import '../../features/individuals/features/basic_info/data/datasources/basic_info_remote_data_source.dart'
    as _i25;
import '../../features/individuals/features/basic_info/data/repositories/basic_info_repository_impl.dart'
    as _i500;
import '../../features/individuals/features/basic_info/domain/repositories/basic_info_repository.dart'
    as _i591;
import '../../features/individuals/features/basic_info/domain/usecases/save_basic_info_usecase.dart'
    as _i961;
import '../../features/individuals/features/basic_info/presentation/cubit/basic_info_cubit.dart'
    as _i37;
import '../../features/individuals/features/certifications/data/datasources/certification_remote_data_source.dart'
    as _i607;
import '../../features/individuals/features/certifications/data/repositories/certification_repository_impl.dart'
    as _i852;
import '../../features/individuals/features/certifications/domain/repositories/certification_repository.dart'
    as _i320;
import '../../features/individuals/features/certifications/domain/usecases/add_certification_usecase.dart'
    as _i289;
import '../../features/individuals/features/certifications/domain/usecases/delete_certification_usecase.dart'
    as _i244;
import '../../features/individuals/features/certifications/domain/usecases/get_certifications_usecase.dart'
    as _i440;
import '../../features/individuals/features/certifications/domain/usecases/update_certification_usecase.dart'
    as _i860;
import '../../features/individuals/features/certifications/presentation/cubit/certification_cubit.dart'
    as _i848;
import '../../features/individuals/features/education/data/datasources/education_remote_data_source.dart'
    as _i380;
import '../../features/individuals/features/education/data/repositories/education_repository_impl.dart'
    as _i999;
import '../../features/individuals/features/education/domain/repositories/education_repository.dart'
    as _i843;
import '../../features/individuals/features/education/domain/usecases/add_education_usecase.dart'
    as _i965;
import '../../features/individuals/features/education/domain/usecases/delete_education_usecase.dart'
    as _i947;
import '../../features/individuals/features/education/domain/usecases/get_educations_usecase.dart'
    as _i947;
import '../../features/individuals/features/education/domain/usecases/update_education_usecase.dart'
    as _i906;
import '../../features/individuals/features/education/presentation/cubit/education_cubit.dart'
    as _i803;
import '../../features/individuals/features/job_preferences/data/datasources/job_preferences_remote_datasource.dart'
    as _i466;
import '../../features/individuals/features/job_preferences/data/repositories/job_preferences_repository_impl.dart'
    as _i942;
import '../../features/individuals/features/job_preferences/domain/repositories/job_preferences_repository.dart'
    as _i248;
import '../../features/individuals/features/job_preferences/domain/usecases/get_job_preferences_usecase.dart'
    as _i43;
import '../../features/individuals/features/job_preferences/domain/usecases/update_job_preferences_usecase.dart'
    as _i476;
import '../../features/individuals/features/job_preferences/presentation/cubit/job_preferences_cubit.dart'
    as _i387;
import '../../features/individuals/features/skills_languages/data/datasources/skills_languages_remote_data_source.dart'
    as _i354;
import '../../features/individuals/features/skills_languages/data/repositories/profile_repository_impl.dart'
    as _i676;
import '../../features/individuals/features/skills_languages/domain/repositories/skills_languages_repository.dart'
    as _i122;
import '../../features/individuals/features/skills_languages/presentation/cubit/skills_languages_cubit.dart'
    as _i201;
import '../../features/individuals/features/work_experience/data/datasources/work_experience_remote_data_source.dart'
    as _i271;
import '../../features/individuals/features/work_experience/data/repositories/work_experience_repository_impl.dart'
    as _i51;
import '../../features/individuals/features/work_experience/domain/repositories/work_experience_repository.dart'
    as _i651;
import '../../features/individuals/features/work_experience/domain/usecases/add_work_experience_usecase.dart'
    as _i794;
import '../../features/individuals/features/work_experience/domain/usecases/delete_work_experience_usecase.dart'
    as _i176;
import '../../features/individuals/features/work_experience/domain/usecases/get_work_experiences_usecase.dart'
    as _i786;
import '../../features/individuals/features/work_experience/domain/usecases/update_work_experience_usecase.dart'
    as _i56;
import '../../features/individuals/features/work_experience/presentation/cubit/work_experience_cubit.dart'
    as _i760;
import '../../features/payment/data/datasources/payment_remote_data_source.dart'
    as _i811;
import '../../features/payment/data/repositories/payment_repository_impl.dart'
    as _i265;
import '../../features/payment/domain/usecases/process_payment_usecase.dart'
    as _i432;
import '../../features/payment/export_payment.dart' as _i903;
import '../../features/payment/presentation/cubit/payment_cubit.dart' as _i513;
import '../../features/shared/user_cubit.dart' as _i171;
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
    gh.lazySingleton<_i171.UserCubit>(
      () => _i171.UserCubit(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i252.CompanyRemoteDataSource>(
      () => _i252.CompanyRemoteDataSource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i811.PaymentRemoteDataSource>(
      () => _i811.PaymentRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i733.AboutMeRemoteDataSource>(
      () => _i733.AboutMeRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i697.WathqRemoteDataSource>(
      () => _i697.WathqRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i861.CrInfoRepository>(
      () => _i319.CrInfoRepositoryImpl(gh<_i697.WathqRemoteDataSource>()),
    );
    gh.lazySingleton<_i542.AboutMeRepository>(
      () => _i633.AboutMeRepositoryImpl(
        gh<_i733.AboutMeRemoteDataSource>(),
        gh<_i454.SupabaseClient>(),
      ),
    );
    gh.lazySingleton<_i380.EducationRemoteDataSource>(
      () => _i380.EducationRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i466.JobPreferencesRemoteDataSource>(
      () =>
          _i466.JobPreferencesRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i1047.DeleteAboutMeVideoUseCase>(
      () => _i1047.DeleteAboutMeVideoUseCase(gh<_i542.AboutMeRepository>()),
    );
    gh.lazySingleton<_i250.SaveAboutMeUseCase>(
      () => _i250.SaveAboutMeUseCase(gh<_i542.AboutMeRepository>()),
    );
    gh.lazySingleton<_i161.AuthRemoteDataSource>(
      () => _i161.AuthRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i843.EducationRepository>(
      () =>
          _i999.EducationRepositoryImpl(gh<_i380.EducationRemoteDataSource>()),
    );
    gh.factory<_i333.GetCrInfo>(
      () => _i333.GetCrInfo(gh<_i861.CrInfoRepository>()),
    );
    gh.lazySingleton<_i607.CertificationRemoteDataSource>(
      () => _i607.CertificationRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i354.SkillsLanguagesRemoteDataSource>(
      () =>
          _i354.SkillsLanguagesRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i271.WorkExperienceRemoteDataSource>(
      () =>
          _i271.WorkExperienceRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i122.SkillsLanguagesRepository>(
      () => _i676.SkillsLanguagesRepositoryImpl(
        gh<_i354.SkillsLanguagesRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i25.BasicInfoRemoteDataSource>(
      () => _i25.BasicInfoRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i248.JobPreferencesRepository>(
      () => _i942.JobPreferencesRepositoryImpl(
        gh<_i466.JobPreferencesRemoteDataSource>(),
      ),
    );
    gh.factory<_i201.SkillsLanguagesCubit>(
      () => _i201.SkillsLanguagesCubit(gh<_i122.SkillsLanguagesRepository>()),
    );
    gh.factory<_i786.CompanyRepository>(
      () => _i624.CompanyRepositoryImpl(gh<_i252.CompanyRemoteDataSource>()),
    );
    gh.lazySingleton<_i651.WorkExperienceRepository>(
      () => _i51.WorkExperienceRepositoryImpl(
        gh<_i271.WorkExperienceRemoteDataSource>(),
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
    gh.lazySingleton<_i965.AddEducationUseCase>(
      () => _i965.AddEducationUseCase(gh<_i843.EducationRepository>()),
    );
    gh.lazySingleton<_i947.DeleteEducationUseCase>(
      () => _i947.DeleteEducationUseCase(gh<_i843.EducationRepository>()),
    );
    gh.lazySingleton<_i947.GetEducationsUseCase>(
      () => _i947.GetEducationsUseCase(gh<_i843.EducationRepository>()),
    );
    gh.lazySingleton<_i906.UpdateEducationUseCase>(
      () => _i906.UpdateEducationUseCase(gh<_i843.EducationRepository>()),
    );
    gh.factory<_i803.EducationCubit>(
      () => _i803.EducationCubit(
        gh<_i947.GetEducationsUseCase>(),
        gh<_i947.DeleteEducationUseCase>(),
        gh<_i965.AddEducationUseCase>(),
        gh<_i906.UpdateEducationUseCase>(),
      ),
    );
    gh.lazySingleton<_i320.CertificationRepository>(
      () => _i852.CertificationRepositoryImpl(
        gh<_i607.CertificationRemoteDataSource>(),
        gh<_i454.SupabaseClient>(),
      ),
    );
    gh.factory<_i289.AddCertificationUseCase>(
      () => _i289.AddCertificationUseCase(gh<_i320.CertificationRepository>()),
    );
    gh.factory<_i244.DeleteCertificationUseCase>(
      () =>
          _i244.DeleteCertificationUseCase(gh<_i320.CertificationRepository>()),
    );
    gh.factory<_i440.GetCertificationsUseCase>(
      () => _i440.GetCertificationsUseCase(gh<_i320.CertificationRepository>()),
    );
    gh.factory<_i860.UpdateCertificationUseCase>(
      () =>
          _i860.UpdateCertificationUseCase(gh<_i320.CertificationRepository>()),
    );
    gh.factory<_i781.AboutMeCubit>(
      () => _i781.AboutMeCubit(
        gh<_i250.SaveAboutMeUseCase>(),
        gh<_i1047.DeleteAboutMeVideoUseCase>(),
      ),
    );
    gh.lazySingleton<_i43.GetJobPreferencesUseCase>(
      () => _i43.GetJobPreferencesUseCase(gh<_i248.JobPreferencesRepository>()),
    );
    gh.lazySingleton<_i476.UpdateJobPreferencesUseCase>(
      () => _i476.UpdateJobPreferencesUseCase(
        gh<_i248.JobPreferencesRepository>(),
      ),
    );
    gh.lazySingleton<_i243.RemoveCandidateBookmark>(
      () => _i243.RemoveCandidateBookmark(gh<_i786.CompanyRepository>()),
    );
    gh.factory<_i533.AddCandidateBookmark>(
      () => _i533.AddCandidateBookmark(gh<_i786.CompanyRepository>()),
    );
    gh.factory<_i528.CheckCompanyStatus>(
      () => _i528.CheckCompanyStatus(gh<_i786.CompanyRepository>()),
    );
    gh.factory<_i831.GetCompanyBookmarks>(
      () => _i831.GetCompanyBookmarks(gh<_i786.CompanyRepository>()),
    );
    gh.factory<_i303.GetCompanyProfile>(
      () => _i303.GetCompanyProfile(gh<_i786.CompanyRepository>()),
    );
    gh.factory<_i754.SearchCandidates>(
      () => _i754.SearchCandidates(gh<_i786.CompanyRepository>()),
    );
    gh.factory<_i923.UpdateCompanyProfile>(
      () => _i923.UpdateCompanyProfile(gh<_i786.CompanyRepository>()),
    );
    gh.lazySingleton<_i432.ProcessPaymentUseCase>(
      () => _i432.ProcessPaymentUseCase(gh<_i903.PaymentRepository>()),
    );
    gh.factory<_i401.CompanyBloc>(
      () => _i401.CompanyBloc(
        gh<_i303.GetCompanyProfile>(),
        gh<_i923.UpdateCompanyProfile>(),
        gh<_i754.SearchCandidates>(),
        gh<_i533.AddCandidateBookmark>(),
        gh<_i831.GetCompanyBookmarks>(),
        gh<_i528.CheckCompanyStatus>(),
        gh<_i468.RegisterCompany>(),
        gh<_i742.VerifyCompanyQR>(),
        gh<_i243.RemoveCandidateBookmark>(),
      ),
    );
    gh.factory<_i550.CrInfoCubit>(
      () => _i550.CrInfoCubit(getCrInfo: gh<_i333.GetCrInfo>()),
    );
    gh.factory<_i387.JobPreferencesCubit>(
      () => _i387.JobPreferencesCubit(
        gh<_i43.GetJobPreferencesUseCase>(),
        gh<_i476.UpdateJobPreferencesUseCase>(),
      ),
    );
    gh.lazySingleton<_i591.BasicInfoRepository>(
      () => _i500.BasicInfoRepositoryImpl(gh<_i25.BasicInfoRemoteDataSource>()),
    );
    gh.factory<_i848.CertificationCubit>(
      () => _i848.CertificationCubit(
        gh<_i440.GetCertificationsUseCase>(),
        gh<_i244.DeleteCertificationUseCase>(),
        gh<_i289.AddCertificationUseCase>(),
        gh<_i860.UpdateCertificationUseCase>(),
      ),
    );
    gh.lazySingleton<_i794.AddWorkExperienceUseCase>(
      () =>
          _i794.AddWorkExperienceUseCase(gh<_i651.WorkExperienceRepository>()),
    );
    gh.lazySingleton<_i176.DeleteWorkExperienceUseCase>(
      () => _i176.DeleteWorkExperienceUseCase(
        gh<_i651.WorkExperienceRepository>(),
      ),
    );
    gh.lazySingleton<_i786.GetWorkExperiencesUseCase>(
      () =>
          _i786.GetWorkExperiencesUseCase(gh<_i651.WorkExperienceRepository>()),
    );
    gh.lazySingleton<_i56.UpdateWorkExperienceUseCase>(
      () => _i56.UpdateWorkExperienceUseCase(
        gh<_i651.WorkExperienceRepository>(),
      ),
    );
    gh.factory<_i760.WorkExperienceCubit>(
      () => _i760.WorkExperienceCubit(
        gh<_i786.GetWorkExperiencesUseCase>(),
        gh<_i176.DeleteWorkExperienceUseCase>(),
        gh<_i794.AddWorkExperienceUseCase>(),
        gh<_i56.UpdateWorkExperienceUseCase>(),
      ),
    );
    gh.factory<_i111.GetCurrentUser>(
      () => _i111.GetCurrentUser(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i428.Login>(() => _i428.Login(gh<_i787.AuthRepository>()));
    gh.factory<_i152.ResendOTP>(
      () => _i152.ResendOTP(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i727.SendOTP>(() => _i727.SendOTP(gh<_i787.AuthRepository>()));
    gh.factory<_i568.SignOut>(() => _i568.SignOut(gh<_i787.AuthRepository>()));
    gh.factory<_i190.SignUp>(() => _i190.SignUp(gh<_i787.AuthRepository>()));
    gh.factory<_i975.VerifyOTP>(
      () => _i975.VerifyOTP(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i513.PaymentCubit>(
      () => _i513.PaymentCubit(gh<_i903.ProcessPaymentUseCase>()),
    );
    gh.lazySingleton<_i961.SaveBasicInfoUseCase>(
      () => _i961.SaveBasicInfoUseCase(gh<_i591.BasicInfoRepository>()),
    );
    gh.factory<_i37.BasicInfoCubit>(
      () => _i37.BasicInfoCubit(gh<_i961.SaveBasicInfoUseCase>()),
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
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i113.RegisterModule {}
