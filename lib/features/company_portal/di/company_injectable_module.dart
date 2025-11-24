import 'package:graduation_project/features/company_portal/data/data_sources/company_portal_data_source.dart';
import 'package:graduation_project/features/company_portal/data/repositories/company_portal_repository_impl.dart';
import 'package:graduation_project/features/company_portal/domain/repositories/company_portal_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain/usecases/register_company.dart';
import '../domain/usecases/get_company_profile.dart';
import '../domain/usecases/update_company_profile.dart';
import '../domain/usecases/search_candidates.dart';

/// All dependencies for Company Portal feature
@module
abstract class CompanyModule {
  // ---------------- DATA LAYER ----------------
  @lazySingleton
  CompanyRemoteDataSource provideRemoteDS(SupabaseClient supabase) =>
      CompanyRemoteDataSource(supabase);

  @lazySingleton
  CompanyRepository provideCompanyRepository(CompanyRemoteDataSource ds) =>
      CompanyRepositoryImpl(ds);

  // ---------------- USE CASES ----------------
  @factoryMethod
  RegisterCompany registerCompany(CompanyRepository repo) =>
      RegisterCompany(repo);

  @factoryMethod
  GetCompanyProfile getCompanyProfile(CompanyRepository repo) =>
      GetCompanyProfile(repo);

  @factoryMethod
  UpdateCompanyProfile updateCompanyProfile(CompanyRepository repo) =>
      UpdateCompanyProfile(repo);

  @factoryMethod
  SearchCandidates searchCandidates(CompanyRepository repo) =>
      SearchCandidates(repo);
}
