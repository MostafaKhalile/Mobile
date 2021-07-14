part of 'brancheworkingdays_bloc.dart';

abstract class BrancheWorkingDaysEvent extends Equatable {
  const BrancheWorkingDaysEvent();

  @override
  List<Object> get props => [];
}

class GetBrancheWorkingDays extends BrancheWorkingDaysEvent {
  final int branchId;

  const GetBrancheWorkingDays(this.branchId);
}
