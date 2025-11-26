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
    gh.lazySingleton<_i781.SaveAboutMeUseCase>(
      () => _i781.SaveAboutMeUseCase(),
    );
    gh.lazySingleton<_i171.UserCubit>(() => _i171.UserCubit());
    gh.lazySingleton<_i252.CompanyRemoteDataSource>(
      () => companyModule.provideRemoteDS(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i161.AuthRemoteDataSource>(
      () => _i161.AuthRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i786.CompanyRepository>(
      () => companyModule.provideCompanyRepository(
        gh<_i252.CompanyRemoteDataSource>(),
      ),
    );
    gh.factory<_i781.AboutMeCubit>(
      () => _i781.AboutMeCubit(gh<_i781.SaveAboutMeUseCase>()),
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
    gh.lazySingleton<_i787.AuthRepository>(
      () => _i153.AuthRepositoryImpl(gh<_i161.AuthRemoteDataSource>()),
    );
    gh.lazySingleton<_i591.BasicInfoRepository>(
      () => _i500.BasicInfoRepositoryImpl(gh<_i25.BasicInfoRemoteDataSource>()),
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

class _$CompanyModule extends _i999.CompanyModule {}
