part of 'company_profile_bloc.dart';

abstract class CompanyProfileState extends Equatable {
  const CompanyProfileState();

  @override
  List<Object> get props => [];
}

class CompanyProfileInitial extends CompanyProfileState {}

class CompanyProfileLoading extends CompanyProfileState {}

class CompanyProfileFinished extends CompanyProfileState {
  final List<CompanyBranche> companyBranches;
  CompanyProfileFinished(this.companyBranches);
}

class CompanyProfileError extends CompanyProfileState {
  final String message;
  CompanyProfileError(this.message);
}
