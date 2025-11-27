import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graduation_project/features/company_portal/data/models/company_model.dart';
import 'package:graduation_project/features/company_portal/domain/entities/company_entity.dart';
import 'package:graduation_project/features/company_portal/domain/usecases/add_candidate_bookmark.dart';
import 'package:graduation_project/features/company_portal/domain/usecases/get_company_profile.dart';
import 'package:graduation_project/features/company_portal/domain/usecases/search_candidates.dart';
import 'package:graduation_project/features/company_portal/domain/usecases/update_company_profile.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'company_event.dart';
part 'company_state.dart';

@injectable
class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  final GetCompanyProfile _getCompanyProfile;
  final UpdateCompanyProfile _updateCompanyProfile;
  final SearchCandidates _searchCandidates;
  final AddCandidateBookmark _addCandidateBookmark;

  CompanyBloc(
    this._getCompanyProfile,
    this._updateCompanyProfile,
    this._searchCandidates,
    this._addCandidateBookmark,
  ) : super(const CompanyInitial()) {
    on<GetCompanyProfileEvent>(_onGetCompanyProfile);
    on<UpdateCompanyProfileEvent>(_onUpdateCompanyProfile);
    on<SearchCandidatesEvent>(_onSearchCandidates);
    on<AddCandidateBookmarkEvent>(_onAddCandidateBookmark);
    on<GetCompanyBookmarksEvent>(_onGetBookmarks);
    on<CheckCompanyStatusEvent>(_onCheckCompanyStatus);
  }

  Future<void> _onGetCompanyProfile(
    GetCompanyProfileEvent event,
    Emitter<CompanyState> emit,
  ) async {
    emit(const CompanyLoading());
    final result = await _getCompanyProfile(event.userId);
    result.when(
      (company) => emit(CompanyLoaded(company)),
      (error) => emit(CompanyError(error)),
    );
  }

  Future<void> _onUpdateCompanyProfile(
    UpdateCompanyProfileEvent event,
    Emitter<CompanyState> emit,
  ) async {
    emit(const CompanyLoading());

    final model = CompanyModel.fromEntity(event.company);
    final updatedModel = model.copyWith(
      companyName: event.company.companyName,
      industry: event.company.industry,
      description: event.company.description,
      city: event.company.city,
      address: event.company.address,
      companySize: event.company.companySize,
      website: event.company.website,
      phone: event.company.phone,
      logoUrl: event.company.logoUrl,
    );
    final updatedEntity = updatedModel.toEntity();

    final result = await _updateCompanyProfile(updatedEntity);
    result.when(
      (company) => emit(CompanyLoaded(company)),
      (error) => emit(CompanyError(error)),
    );
  }

  Future<void> _onSearchCandidates(
    SearchCandidatesEvent event,
    Emitter<CompanyState> emit,
  ) async {
    emit(const CompanyLoading());
    final result = await _searchCandidates(
      city: event.city,
      skill: event.skill,
      experience: event.experience,
    );
    result.when(
      (candidates) => emit(CandidateResults(candidates)),
      (error) => emit(CompanyError(error)),
    );
  }

  Future<void> _onAddCandidateBookmark(
    AddCandidateBookmarkEvent event,
    Emitter<CompanyState> emit,
  ) async {
    final current = state;
    if (current is! CompanyLoaded) return;

    final companyId = current.company.id;
    emit(const CompanyLoading());
    final result = await _addCandidateBookmark(companyId, event.candidateId);
    result.when(
      (_) => emit(const BookmarkAddedSuccessfully()),
      (error) => emit(CompanyError(error)),
    );
  }

  Future<void> _onGetBookmarks(
    GetCompanyBookmarksEvent event,
    Emitter<CompanyState> emit,
  ) async {
    emit(const CompanyLoading());
    final response = await Supabase.instance.client
        .from('company_bookmarks')
        .select('candidate_id, profiles(full_name,skills,city)')
        .eq('company_id', event.companyId);
    final data = List<Map<String, dynamic>>.from(response);
    emit(CompanyBookmarksLoaded(data));
  }

  Future<void> _onCheckCompanyStatus(
    CheckCompanyStatusEvent event,
    Emitter<CompanyState> emit,
  ) async {
    emit(const CompanyLoading());

    final client = Supabase.instance.client;

    final companyResponse = await client
        .from('companies')
        .select('id')
        .eq('user_id', event.userId)
        .maybeSingle();

    final hasProfile = companyResponse != null;
    final companyId = companyResponse?['id'] as String?;

    bool hasPaid = false;

    if (hasProfile && companyId != null) {
      // نتحقق إذا دفعت
      final paymentResponse = await client
          .from('payments')
          .select('status')
          .eq('company_id', companyId)
          .eq('status', 'paid')
          .maybeSingle();

      hasPaid = paymentResponse != null;
    }

    emit(CompanyStatusChecked(hasProfile: hasProfile, hasPaid: hasPaid));
  }
}
