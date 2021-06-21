part of 'brancheworkingdays_bloc.dart';

abstract class BrancheWorkingDaysState extends Equatable {
  const BrancheWorkingDaysState();

  @override
  List<Object> get props => [];
}

class BrancheworkingdaysInitial extends BrancheWorkingDaysState {}

class BrancheWorkingDaysLoading extends BrancheWorkingDaysState {}

class BrancheWorkingDaysSuccess extends BrancheWorkingDaysState {
  final List<BrancheWorkingDay> workingDays;

  BrancheWorkingDaysSuccess(this.workingDays);
}

class BrancheWorkingDaysFaild extends BrancheWorkingDaysState {
  final String message;

  BrancheWorkingDaysFaild(this.message);
}
