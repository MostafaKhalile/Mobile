part of 'company_profile_bloc.dart';

abstract class CompanyProfileState extends Equatable {
  const CompanyProfileState();

  @override
  List<Object> get props => [];
}

class CompanyProfileInitial extends CompanyProfileState {}

class CompanyProfileLoading extends CompanyProfileState {}

class CompanyProfileFinished extends CompanyProfileState {
  final CompanyProfile companyProfile;
  const CompanyProfileFinished(this.companyProfile);
}

class CompanyProfileError extends CompanyProfileState {
  final String message;
  const CompanyProfileError(this.message);
}
