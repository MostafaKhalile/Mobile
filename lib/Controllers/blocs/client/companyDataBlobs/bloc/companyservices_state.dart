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

  CompanyservicesSuccess(this.services);
}

class CompanyservicesFaild extends CompanyservicesState {
  final String message;

  CompanyservicesFaild(this.message);
}
