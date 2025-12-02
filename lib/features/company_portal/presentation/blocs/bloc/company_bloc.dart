// lib/features/company_portal/presentation/bloc/company_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graduation_project/core/di/service_locator.dart';
import 'package:graduation_project/features/company_portal/domain/entities/candidate_entity.dart';
import 'package:graduation_project/features/company_portal/domain/entities/company_entity.dart';
import 'package:graduation_project/features/company_portal/domain/usecases/add_candidate_bookmark.dart';
import 'package:graduation_project/features/company_portal/domain/usecases/check_company_status.dart';
import 'package:graduation_project/features/company_portal/domain/usecases/get_company_bookmarks.dart';
import 'package:graduation_project/features/company_portal/domain/usecases/get_company_profile.dart';
import 'package:graduation_project/features/company_portal/domain/usecases/register_company.dart'; // NEW IMPORT
import 'package:graduation_project/features/company_portal/domain/usecases/search_candidates.dart';
import 'package:graduation_project/features/company_portal/domain/usecases/update_company_profile.dart';
import 'package:graduation_project/features/company_portal/domain/usecases/verify_company_qr.dart'; // NEW IMPORT
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
  final GetCompanyBookmarks _getCompanyBookmarks;
  final CheckCompanyStatus _checkCompanyStatus;
  final RegisterCompany _registerCompany; // NEW INJECTION
  final VerifyCompanyQR _verifyCompanyQR; // NEW INJECTION

  CompanyBloc(
    this._getCompanyProfile,
    this._updateCompanyProfile,
    this._searchCandidates,
    this._addCandidateBookmark,
    this._getCompanyBookmarks,
    this._checkCompanyStatus,
    this._registerCompany, // ADDED
    this._verifyCompanyQR, // ADDED
  ) : super(const CompanyInitial()) {
    on<GetCompanyProfileEvent>(_onGetCompanyProfile);
    on<UpdateCompanyProfileEvent>(_onUpdateCompanyProfile);
    on<SearchCandidatesEvent>(_onSearchCandidates);
    on<AddCandidateBookmarkEvent>(_onAddCandidateBookmark);
    on<GetCompanyBookmarksEvent>(_onGetBookmarks);
    on<CheckCompanyStatusEvent>(_onCheckCompanyStatus);
    on<RegisterCompanyEvent>(_onRegisterCompany); // NEW HANDLER
    on<VerifyCompanyQREvent>(_onVerifyCompanyQR); // NEW HANDLER
  }

  // --- NEW HANDLER ---
  Future<void> _onRegisterCompany(
    RegisterCompanyEvent event,
    Emitter<CompanyState> emit,
  ) async {
    emit(const CompanyLoading());
    final result = await _registerCompany(
      email: event.email,
      password: event.password,
    );
    result.when(
      // On success, the BLoC moves to the loaded state, ready for profile completion
      (company) => emit(CompanyLoaded(company)),
      (failure) => emit(CompanyError(failure.message)),
    );
  }

  Future<void> _onGetCompanyProfile(
    GetCompanyProfileEvent event,
    Emitter<CompanyState> emit,
  ) async {
    emit(const CompanyLoading());
    final result = await _getCompanyProfile(event.userId);
    result.when(
      (company) => emit(CompanyLoaded(company)),
      (failure) => emit(CompanyError(failure.message)),
    );
  }

  Future<void> _onUpdateCompanyProfile(
    UpdateCompanyProfileEvent event,
    Emitter<CompanyState> emit,
  ) async {
    emit(const CompanyLoading());
    final result = await _updateCompanyProfile(event.company);

    result.when(
      (company) => emit(CompanyLoaded(company)),
      (failure) => emit(CompanyError(failure.message)),
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
      (failure) => emit(CompanyError(failure.message)),
    );
  }

  Future<void> _onAddCandidateBookmark(
    AddCandidateBookmarkEvent event,
    Emitter<CompanyState> emit,
  ) async {
    final current = state;
    if (current is! CompanyLoaded) {
      emit(const CompanyError('Cannot bookmark: Company profile not loaded.'));
      return;
    }

    emit(const CompanyLoading());
    final result = await _addCandidateBookmark(
      serviceLocator.get<SupabaseClient>().auth.currentUser!.id,
      event.candidateId,
    );

    result.when(
      (_) => emit(const BookmarkAddedSuccessfully()),
      (failure) => emit(CompanyError(failure.message)),
    );
  }

  Future<void> _onGetBookmarks(
    GetCompanyBookmarksEvent event,
    Emitter<CompanyState> emit,
  ) async {
    emit(const CompanyLoading());
    final result = await _getCompanyBookmarks(event.companyId);

    result.when(
      (candidates) => emit(CompanyBookmarksLoaded(candidates)),
      (failure) => emit(CompanyError(failure.message)),
    );
  }

  Future<void> _onCheckCompanyStatus(
    CheckCompanyStatusEvent event,
    Emitter<CompanyState> emit,
  ) async {
    emit(const CompanyLoading());
    final result = await _checkCompanyStatus(event.userId);

    result.when(
      (status) => emit(
        CompanyStatusChecked(
          hasProfile: status['hasProfile']!,
          hasPaid: status['hasPaid']!,
        ),
      ),
      (failure) => emit(CompanyError(failure.message)),
    );
  }

  // --- NEW HANDLER ---
  Future<void> _onVerifyCompanyQR(
    VerifyCompanyQREvent event,
    Emitter<CompanyState> emit,
  ) async {
    emit(const CompanyLoading());
    final result = await _verifyCompanyQR(event.qrCodeData);

    result.when(
      (_) => emit(const QRVerificationSuccess()),
      (failure) => emit(CompanyError(failure.message)),
    );
  }
}
