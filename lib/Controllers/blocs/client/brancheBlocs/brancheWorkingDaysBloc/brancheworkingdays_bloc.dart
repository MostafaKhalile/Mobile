import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techtime/Controllers/Repositories/client/branches/branches_repository.dart';
import 'package:techtime/Models/client/companyData/brancheData/branche_working_day.dart';

part 'brancheworkingdays_event.dart';
part 'brancheworkingdays_state.dart';

class BrancheWorkingDaysBloc
    extends Bloc<BrancheWorkingDaysEvent, BrancheWorkingDaysState> {
  BrancheWorkingDaysBloc(this._branchesRepo)
      : super(BrancheworkingdaysInitial());
  final BranchesRepository _branchesRepo;

  @override
  Stream<BrancheWorkingDaysState> mapEventToState(
    BrancheWorkingDaysEvent event,
  ) async* {
    if (event is GetBrancheWorkingDays) {
      yield BrancheWorkingDaysLoading();
      try {
        final workingDays =
            await _branchesRepo.getBrancheWorkingDays(event.branchId);
        yield BrancheWorkingDaysSuccess(workingDays);
      } catch (e) {
        yield BrancheWorkingDaysFaild(e.toString());
      }
    }
  }
}
