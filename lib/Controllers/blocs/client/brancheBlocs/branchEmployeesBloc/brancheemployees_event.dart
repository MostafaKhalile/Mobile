part of 'brancheemployees_bloc.dart';

abstract class BrancheemployeesEvent extends Equatable {
  const BrancheemployeesEvent();

  @override
  List<Object> get props => [];
}

class GetBrancheEmployees extends BrancheemployeesEvent {
  final int branchId;

  GetBrancheEmployees(this.branchId);
}
