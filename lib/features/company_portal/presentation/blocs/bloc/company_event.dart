part of 'company_bloc.dart';

abstract class CompanyEvent extends Equatable {
  const CompanyEvent();
  @override
  List<Object?> get props => [];
}

class GetCompanyProfileEvent extends CompanyEvent {
  final String userId;
  const GetCompanyProfileEvent(this.userId);
  @override
  List<Object?> get props => [userId];
}

class RegisterCompanyEvent extends CompanyEvent {
  final String email;
  final String password;
  const RegisterCompanyEvent({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}

class UpdateCompanyProfileEvent extends CompanyEvent {
  final CompanyEntity company;

  const UpdateCompanyProfileEvent({required this.company});

  @override
  List<Object> get props => [company];
}

class SearchCandidatesEvent extends CompanyEvent {
  final String? location;
  final List<String>? skills;
  final List<String>? employmentTypes;
  final bool? canRelocate;
  final List<String>? languages;
  final List<String>? workModes;
  final String? jobTitle;
  final List<String>? targetRoles;

  const SearchCandidatesEvent({
    this.location,
    this.skills,
    this.employmentTypes,
    this.canRelocate,
    this.languages,
    this.workModes,
    this.jobTitle,
    this.targetRoles,
  });
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

class VerifyCompanyQREvent extends CompanyEvent {
  final String qrCodeData;
  const VerifyCompanyQREvent(this.qrCodeData);
  @override
  List<Object?> get props => [qrCodeData];
}

class RemoveCandidateBookmarkEvent extends CompanyEvent {
  final String candidateId;
  const RemoveCandidateBookmarkEvent(this.candidateId);
  @override
  List<Object?> get props => [candidateId];
}
