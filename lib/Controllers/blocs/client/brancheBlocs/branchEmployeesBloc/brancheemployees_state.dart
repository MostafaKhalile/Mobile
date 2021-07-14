part of 'brancheemployees_bloc.dart';

abstract class BrancheemployeesState extends Equatable {
  const BrancheemployeesState();

  @override
  List<Object> get props => [];
}

class BrancheemployeesInitial extends BrancheemployeesState {}

class BrancheemployeesLoading extends BrancheemployeesState {}

class BrancheemployeesSuccess extends BrancheemployeesState {
  final List<CompanyEmployee> employees;

  const BrancheemployeesSuccess(this.employees);
}

class BrancheemployeesFaild extends BrancheemployeesState {
  final String message;

  const BrancheemployeesFaild(this.message);
}
