part of 'bookmarks_bloc.dart';

abstract class BookmarksEvent extends Equatable {
  const BookmarksEvent();

  @override
  List<Object?> get props => [];
}

class LoadBookmarksEvent extends BookmarksEvent {
  final String companyId;
  const LoadBookmarksEvent(this.companyId);

  @override
  List<Object?> get props => [companyId];
}

class AddBookmarkEvent extends BookmarksEvent {
  final String candidateId;
  final String companyId;

  const AddBookmarkEvent({required this.candidateId, required this.companyId});

  @override
  List<Object?> get props => [candidateId, companyId];
}

class RemoveBookmarkEvent extends BookmarksEvent {
  final String candidateId;
  final String companyId;

  const RemoveBookmarkEvent({
    required this.candidateId,
    required this.companyId,
  });

  @override
  List<Object?> get props => [candidateId, companyId];
}

class ToggleBookmarkEvent extends BookmarksEvent {
  final String candidateId;
  // يمكن إضافة companyId إذا كنت لا تجلبه من داخل البلوك

  const ToggleBookmarkEvent({required this.candidateId});

  @override
  List<Object> get props => [candidateId];
}
