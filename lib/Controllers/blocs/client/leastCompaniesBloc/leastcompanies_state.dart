part of 'leastcompanies_bloc.dart';

abstract class LeastcompaniesState extends Equatable {
  const LeastcompaniesState();

  @override
  List<Object> get props => [];
}

class LeastcompaniesInitial extends LeastcompaniesState {}

class Leastcompaniesloading extends LeastcompaniesState {
  const Leastcompaniesloading();
}

class LeastCompaniesLoaded extends LeastcompaniesState {
  final List<Company> leastCompanies;
  const LeastCompaniesLoaded(this.leastCompanies);
}

class LeastCompaniesError extends LeastcompaniesState {
  final String message;
  const LeastCompaniesError(this.message);
}
