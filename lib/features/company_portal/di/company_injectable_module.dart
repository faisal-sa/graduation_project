import 'package:graduation_project/features/company_portal/data/data_sources/company_portal_data_source.dart';
import 'package:graduation_project/features/company_portal/data/repositories/company_portal_repository_impl.dart';
import 'package:graduation_project/features/company_portal/domain/repositories/company_portal_repository.dart';
import 'package:graduation_project/features/company_portal/domain/usecases/add_candidate_bookmark.dart';
import 'package:graduation_project/features/company_portal/domain/usecases/get_company_profile.dart';
import 'package:graduation_project/features/company_portal/domain/usecases/register_company.dart';
import 'package:graduation_project/features/company_portal/domain/usecases/search_candidates.dart';
import 'package:graduation_project/features/company_portal/domain/usecases/update_company_profile.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@module
abstract class CompanyModule {
  // ---------------- DATA LAYER ----------------
  @lazySingleton
  CompanyRemoteDataSource provideRemoteDS(SupabaseClient supabase) =>
      CompanyRemoteDataSource(supabase);

  @lazySingleton
  CompanyRepository provideCompanyRepository(CompanyRemoteDataSource ds) =>
      CompanyRepositoryImpl(ds);

  // ---------------- USE CASES ----------------
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

  @factoryMethod
  AddCandidateBookmark addCandidateBookmark(CompanyRepository repo) =>
      AddCandidateBookmark(repo);
}
