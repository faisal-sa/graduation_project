part of 'company_bloc.dart';

abstract class CompanyEvent extends Equatable {
  const CompanyEvent();
  @override
  List<Object?> get props => [];
}

class GetCompanyProfileEvent extends CompanyEvent {
  final String userId;
  const GetCompanyProfileEvent(this.userId);
}

class UpdateCompanyProfileEvent extends CompanyEvent {
  final CompanyEntity company;
  const UpdateCompanyProfileEvent(this.company);
}

class SearchCandidatesEvent extends CompanyEvent {
  final String? city;
  final String? skill;
  final String? experience;
  const SearchCandidatesEvent({this.city, this.skill, this.experience});
}

class AddCandidateBookmarkEvent extends CompanyEvent {
  final String candidateId;
  const AddCandidateBookmarkEvent(this.candidateId);
}

class GetCompanyBookmarksEvent extends CompanyEvent {
  final String companyId;
  const GetCompanyBookmarksEvent(this.companyId);
}

class CheckCompanyStatusEvent extends CompanyEvent {
  final String userId;
  const CheckCompanyStatusEvent(this.userId);
}
