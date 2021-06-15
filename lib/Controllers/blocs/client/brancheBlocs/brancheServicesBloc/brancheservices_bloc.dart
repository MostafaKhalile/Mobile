import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techtime/Controllers/Repositories/client/branches/branches_repository.dart';
import 'package:techtime/Models/client/companyData/company_service.dart';

part 'brancheservices_event.dart';
part 'brancheservices_state.dart';

class BrancheservicesBloc
    extends Bloc<BrancheservicesEvent, BrancheservicesState> {
  BrancheservicesBloc(this._branchesRepo) : super(BrancheservicesInitial());
  final BranchesRepository _branchesRepo;

  @override
  Stream<BrancheservicesState> mapEventToState(
    BrancheservicesEvent event,
  ) async* {
    if (event is GetBrancheservices) {
      yield BrancheservicesLoading();
      try {
        final companies =
            await _branchesRepo.getBrancheServices(event.branchId);
        yield BrancheservicesSuccess(companies);
      } catch (e) {
        yield BrancheservicesFaild(e.toString());
      }
    }
  }
}
