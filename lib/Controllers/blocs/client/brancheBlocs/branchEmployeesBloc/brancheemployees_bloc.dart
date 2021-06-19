import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techtime/Controllers/Repositories/client/branches/branches_repository.dart';
import 'package:techtime/Models/client/companyData/brancheData/company_employee.dart';

part 'brancheemployees_event.dart';
part 'brancheemployees_state.dart';

class BrancheemployeesBloc
    extends Bloc<BrancheemployeesEvent, BrancheemployeesState> {
  BrancheemployeesBloc(this._branchesRepo) : super(BrancheemployeesInitial());
  final BranchesRepository _branchesRepo;

  @override
  Stream<BrancheemployeesState> mapEventToState(
    BrancheemployeesEvent event,
  ) async* {
    if (event is GetBrancheEmployees) {
      yield BrancheemployeesLoading();
      try {
        final companies =
            await _branchesRepo.getBrancheEmployees(event.branchId);
        yield BrancheemployeesSuccess(companies);
      } catch (e) {
        print(e.toString());
        yield BrancheemployeesFaild(e.toString());
      }
    }
  }
}
