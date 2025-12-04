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
import 'package:graduation_project/features/company_portal/domain/usecases/register_company.dart';
import 'package:graduation_project/features/company_portal/domain/usecases/remove_candidate_bookmark.dart';
import 'package:graduation_project/features/company_portal/domain/usecases/search_candidates.dart';
import 'package:graduation_project/features/company_portal/domain/usecases/update_company_profile.dart';
import 'package:graduation_project/features/company_portal/domain/usecases/verify_company_qr.dart';
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
  final RegisterCompany _registerCompany;
  final VerifyCompanyQR _verifyCompanyQR;
  final RemoveCandidateBookmark _removeCandidateBookmark;

  CompanyBloc(
    this._getCompanyProfile,
    this._updateCompanyProfile,
    this._searchCandidates,
    this._addCandidateBookmark,
    this._getCompanyBookmarks,
    this._checkCompanyStatus,
    this._registerCompany,
    this._verifyCompanyQR,
    this._removeCandidateBookmark,
  ) : super(const CompanyInitial()) {
    on<GetCompanyProfileEvent>(_onGetCompanyProfile);
    on<UpdateCompanyProfileEvent>(_onUpdateCompanyProfile);
    on<SearchCandidatesEvent>(_onSearchCandidates);
    on<AddCandidateBookmarkEvent>(_onAddCandidateBookmark);
    on<GetCompanyBookmarksEvent>(_onGetBookmarks);
    on<CheckCompanyStatusEvent>(_onCheckCompanyStatus);
    on<RegisterCompanyEvent>(_onRegisterCompany);
    on<VerifyCompanyQREvent>(_onVerifyCompanyQR);
    on<RemoveCandidateBookmarkEvent>(_onRemoveBookmark);
  }

  Future<void> _onRemoveBookmark(
    RemoveCandidateBookmarkEvent event,
    Emitter<CompanyState> emit,
  ) async {
    if (state is! CompanyBookmarksLoaded) return;

    final currentState = state as CompanyBookmarksLoaded;
    final originalList = currentState.bookmarks;

    final updatedList = originalList
        .where((c) => c.id != event.candidateId)
        .toList();

    emit(CompanyBookmarksLoaded(updatedList));

    final companyId = serviceLocator.get<SupabaseClient>().auth.currentUser?.id;
    if (companyId != null) {
      final result = await _removeCandidateBookmark(
        companyId,
        event.candidateId,
      );

      result.when(
        (success) {
          emit(const BookmarkRemovedSuccessfully());
          emit(CompanyBookmarksLoaded(updatedList));
        },
        (failure) {
          emit(CompanyBookmarksLoaded(originalList));
          emit(CompanyError("Failed to delete: ${failure.message}"));
        },
      );
    }
  }

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
      location: event.location,
      skills: event.skills,
      employmentTypes: event.employmentTypes,
      canRelocate: event.canRelocate,
      languages: event.languages,
      workModes: event.workModes,
      jobTitle: event.jobTitle,
      targetRoles: event.targetRoles,
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
    if (state is! CandidateResults) return;

    final currentState = state as CandidateResults;
    final companyId = serviceLocator.get<SupabaseClient>().auth.currentUser?.id;

    if (companyId == null) {
      emit(const CompanyError('Authentication required.'));
      return;
    }

    final updatedBookmarks = Set<String>.from(currentState.bookmarkedIds);
    updatedBookmarks.add(event.candidateId);

    emit(
      CandidateResults(
        currentState.candidates,
        company: currentState.company,
        bookmarkedIds: updatedBookmarks,
      ),
    );

    final result = await _addCandidateBookmark(companyId, event.candidateId);

    result.when((success) {}, (failure) {
      updatedBookmarks.remove(event.candidateId);

      emit(
        CandidateResults(
          currentState.candidates,
          company: currentState.company,
          bookmarkedIds: updatedBookmarks,
        ),
      );

      emit(CompanyError(failure.message));
    });
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
