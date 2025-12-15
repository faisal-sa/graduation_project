import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graduation_project/features/company_search/domain/usecases/search_candidates.dart';
import 'package:graduation_project/features/shared/data/domain/entities/candidate_entity.dart';
import 'package:injectable/injectable.dart';

part 'search_event.dart';
part 'search_state.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchCandidatesUseCase _searchCandidatesUseCase;

  SearchBloc(this._searchCandidatesUseCase) : super(SearchInitial()) {
    on<PerformSearchEvent>(_onPerformSearch);
    on<ResetSearchEvent>((event, emit) => emit(SearchInitial()));
    on<UpdateLocalBookmarkEvent>(_onUpdateLocalBookmark);
  }

  void _onUpdateLocalBookmark(
    UpdateLocalBookmarkEvent event,
    Emitter<SearchState> emit,
  ) {
    if (state is SearchResultsLoaded) {
      final currentState = state as SearchResultsLoaded;

      final List<CandidateEntity> updatedList = List.of(
        currentState.candidates,
      );

      final index = updatedList.indexWhere((c) => c.id == event.candidateId);
      if (index != -1) {
        updatedList[index] = updatedList[index].copyWith(
          bookmarked: event.isBookmarked,
        );
        emit(SearchResultsLoaded(updatedList));
      }
    }
  }

  Future<void> _onPerformSearch(
    PerformSearchEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoading());

    final result = await _searchCandidatesUseCase(
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
      (candidates) => emit(SearchResultsLoaded(candidates)),
      (failure) => emit(SearchError(failure.message)),
    );
  }
}
