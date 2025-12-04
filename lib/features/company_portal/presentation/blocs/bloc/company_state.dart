part of 'company_bloc.dart';

abstract class CompanyState extends Equatable {
  const CompanyState();
  @override
  List<Object?> get props => [];
}

class CompanyInitial extends CompanyState {
  const CompanyInitial();
}

class BookmarkRemovedSuccessfully extends CompanyState {
  const BookmarkRemovedSuccessfully();
}

class CompanyLoading extends CompanyState {
  final CompanyEntity? company;

  const CompanyLoading({this.company});

  @override
  List<Object?> get props => [company];
}

class CompanyLoaded extends CompanyState {
  final CompanyEntity company;
  const CompanyLoaded(this.company);
  @override
  List<Object?> get props => [company];
}

class CandidateResults extends CompanyState {
  final List<CandidateEntity> candidates;
  final CompanyEntity? company;
  final Set<String> bookmarkedIds;

  const CandidateResults(
    this.candidates, {
    this.company,
    this.bookmarkedIds = const {},
  });

  @override
  List<Object?> get props => [candidates, company, bookmarkedIds];
}

class CompanyBookmarksLoaded extends CompanyState {
  final List<CandidateEntity> bookmarks;
  const CompanyBookmarksLoaded(this.bookmarks);
  @override
  List<Object?> get props => [bookmarks];
}

class BookmarkAddedSuccessfully extends CompanyState {
  final CompanyEntity? company;

  const BookmarkAddedSuccessfully({this.company});

  @override
  List<Object?> get props => [company];
}

class CompanyError extends CompanyState {
  final String message;
  const CompanyError(this.message);
  @override
  List<Object?> get props => [message];
}

class CompanyStatusChecked extends CompanyState {
  final bool hasProfile;
  final bool hasPaid;
  const CompanyStatusChecked({required this.hasProfile, required this.hasPaid});
  @override
  List<Object?> get props => [hasProfile, hasPaid];
}

class QRVerificationSuccess extends CompanyState {
  const QRVerificationSuccess();
}
