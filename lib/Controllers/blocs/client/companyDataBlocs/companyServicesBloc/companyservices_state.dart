part of 'companyservices_bloc.dart';

abstract class CompanyservicesState extends Equatable {
  const CompanyservicesState();

  @override
  List<Object> get props => [];
}

class CompanyservicesInitial extends CompanyservicesState {}

class CompanyservicesLoading extends CompanyservicesState {}

class CompanyservicesSuccess extends CompanyservicesState {
  final List<CompanyService> services;

  const CompanyservicesSuccess(this.services);
}

class CompanyservicesFaild extends CompanyservicesState {
  final String message;

  const CompanyservicesFaild(this.message);
}
