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

  const BrancheservicesSuccess(this.services);
}

class BrancheservicesFaild extends BrancheservicesState {
  final String message;

  const BrancheservicesFaild(this.message);
}
