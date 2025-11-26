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
import '../../features/company_portal/di/company_injectable_module.dart'
    as _i999;
import '../../features/company_portal/domain/repositories/company_portal_repository.dart'
    as _i786;
import '../../features/company_portal/domain/usecases/add_candidate_bookmark.dart'
    as _i533;
import '../../features/company_portal/domain/usecases/get_company_profile.dart'
    as _i303;
import '../../features/company_portal/domain/usecases/register_company.dart'
    as _i468;
import '../../features/company_portal/domain/usecases/search_candidates.dart'
    as _i754;
import '../../features/company_portal/domain/usecases/update_company_profile.dart'
    as _i923;
import '../../features/company_portal/presentation/blocs/bloc/company_bloc.dart'
    as _i401;
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
import '../../features/individuals/features/work_experience/presentation/cubit/form/work_experience_form_cubit.dart'
    as _i381;
import '../../features/individuals/features/work_experience/presentation/cubit/list/work_experience_list_cubit.dart'
    as _i620;
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
    final companyModule = _$CompanyModule();
    await gh.factoryAsync<_i454.SupabaseClient>(
      () => registerModule.supabaseClient,
      preResolve: true,
    );
    gh.lazySingleton<_i171.UserCubit>(() => _i171.UserCubit());
    gh.lazySingleton<_i252.CompanyRemoteDataSource>(
      () => companyModule.provideRemoteDS(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i733.AboutMeRemoteDataSource>(
      () => _i733.AboutMeRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i542.AboutMeRepository>(
      () => _i633.AboutMeRepositoryImpl(
        gh<_i733.AboutMeRemoteDataSource>(),
        gh<_i454.SupabaseClient>(),
      ),
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
    gh.lazySingleton<_i786.CompanyRepository>(
      () => companyModule.provideCompanyRepository(
        gh<_i252.CompanyRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i271.WorkExperienceRemoteDataSource>(
      () =>
          _i271.WorkExperienceRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i25.BasicInfoRemoteDataSource>(
      () => _i25.BasicInfoRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.factory<_i468.RegisterCompany>(
      () => companyModule.registerCompany(gh<_i786.CompanyRepository>()),
    );
    gh.factory<_i303.GetCompanyProfile>(
      () => companyModule.getCompanyProfile(gh<_i786.CompanyRepository>()),
    );
    gh.factory<_i923.UpdateCompanyProfile>(
      () => companyModule.updateCompanyProfile(gh<_i786.CompanyRepository>()),
    );
    gh.factory<_i754.SearchCandidates>(
      () => companyModule.searchCandidates(gh<_i786.CompanyRepository>()),
    );
    gh.factory<_i533.AddCandidateBookmark>(
      () => companyModule.addCandidateBookmark(gh<_i786.CompanyRepository>()),
    );
    gh.factory<_i401.CompanyBloc>(
      () => _i401.CompanyBloc(
        gh<_i303.GetCompanyProfile>(),
        gh<_i923.UpdateCompanyProfile>(),
        gh<_i754.SearchCandidates>(),
        gh<_i533.AddCandidateBookmark>(),
      ),
    );
    gh.lazySingleton<_i651.WorkExperienceRepository>(
      () => _i51.WorkExperienceRepositoryImpl(
        gh<_i271.WorkExperienceRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i787.AuthRepository>(
      () => _i153.AuthRepositoryImpl(gh<_i161.AuthRemoteDataSource>()),
    );
    gh.factory<_i781.AboutMeCubit>(
      () => _i781.AboutMeCubit(
        gh<_i250.SaveAboutMeUseCase>(),
        gh<_i1047.DeleteAboutMeVideoUseCase>(),
      ),
    );
    gh.lazySingleton<_i591.BasicInfoRepository>(
      () => _i500.BasicInfoRepositoryImpl(gh<_i25.BasicInfoRemoteDataSource>()),
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
    gh.factory<_i381.WorkExperienceFormCubit>(
      () => _i381.WorkExperienceFormCubit(
        gh<_i794.AddWorkExperienceUseCase>(),
        gh<_i56.UpdateWorkExperienceUseCase>(),
      ),
    );
    gh.lazySingleton<_i961.SaveBasicInfoUseCase>(
      () => _i961.SaveBasicInfoUseCase(gh<_i591.BasicInfoRepository>()),
    );
    gh.factory<_i37.BasicInfoCubit>(
      () => _i37.BasicInfoCubit(gh<_i961.SaveBasicInfoUseCase>()),
    );
    gh.factory<_i620.WorkExperienceListCubit>(
      () => _i620.WorkExperienceListCubit(
        gh<_i786.GetWorkExperiencesUseCase>(),
        gh<_i176.DeleteWorkExperienceUseCase>(),
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
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i113.RegisterModule {}

class _$CompanyModule extends _i999.CompanyModule {}
