part of 'company_bloc.dart';

abstract class CompanyEvent extends Equatable {
  const CompanyEvent();
  @override
  List<Object?> get props => [];
}

class RegisterCompanyEvent extends CompanyEvent {
  final String email;
  final String password;
  const RegisterCompanyEvent({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}

class GetCompanyProfileEvent extends CompanyEvent {
  final String userId;
  const GetCompanyProfileEvent(this.userId);
  @override
  List<Object?> get props => [userId];
}

// ... (rest of the events: UpdateCompanyProfileEvent, SearchCandidatesEvent, etc.)
class UpdateCompanyProfileEvent extends CompanyEvent {
  final CompanyEntity company;
  const UpdateCompanyProfileEvent(this.company);
  @override
  List<Object?> get props => [company];
}

class SearchCandidatesEvent extends CompanyEvent {
  final String? city;
  final String? skill;
  final String? experience;
  const SearchCandidatesEvent({this.city, this.skill, this.experience});
  @override
  List<Object?> get props => [city, skill, experience];
}

class AddCandidateBookmarkEvent extends CompanyEvent {
  final String candidateId;
  const AddCandidateBookmarkEvent(this.candidateId);
  @override
  List<Object?> get props => [candidateId];
}

class GetCompanyBookmarksEvent extends CompanyEvent {
  final String companyId;
  const GetCompanyBookmarksEvent(this.companyId);
  @override
  List<Object?> get props => [companyId];
}

class CheckCompanyStatusEvent extends CompanyEvent {
  final String userId;
  const CheckCompanyStatusEvent(this.userId);
  @override
  List<Object?> get props => [userId];
}
