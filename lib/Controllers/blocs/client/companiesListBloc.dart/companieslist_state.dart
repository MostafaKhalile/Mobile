part of 'companieslist_bloc.dart';

abstract class CompanieslistState extends Equatable {
  const CompanieslistState();

  @override
  List<Object> get props => [];
}

class CompanieslistInitial extends CompanieslistState {}

class CompanieslistLoading extends CompanieslistState {
  CompanieslistLoading();
}

class CompanieslistFinished extends CompanieslistState {
  final List<Company> companies;

  CompanieslistFinished(this.companies);
}

class CompanieslistError extends CompanieslistState {
  final String message;

  CompanieslistError(this.message);
}
