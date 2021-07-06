part of 'companieslist_bloc.dart';

abstract class CompanieslistState extends Equatable {
  const CompanieslistState();

  @override
  List<Object> get props => [];
}

class CompanieslistInitial extends CompanieslistState {}

class CompanieslistLoading extends CompanieslistState {
  const CompanieslistLoading();
}

class CompanieslistFinished extends CompanieslistState {
  final List<Company> companies;

  const CompanieslistFinished(this.companies);
}

class CompanieslistError extends CompanieslistState {
  final String message;

  const CompanieslistError(this.message);
}
