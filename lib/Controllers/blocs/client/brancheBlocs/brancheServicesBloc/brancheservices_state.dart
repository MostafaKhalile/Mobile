part of 'brancheservices_bloc.dart';

abstract class BrancheservicesState extends Equatable {
  const BrancheservicesState();

  @override
  List<Object> get props => [];
}

class BrancheservicesInitial extends BrancheservicesState {}

class BrancheservicesLoading extends BrancheservicesState {}

class BrancheservicesSuccess extends BrancheservicesState {
  final List<CompanyService> services;

  BrancheservicesSuccess(this.services);
}

class BrancheservicesFaild extends BrancheservicesState {
  final String message;

  BrancheservicesFaild(this.message);
}
