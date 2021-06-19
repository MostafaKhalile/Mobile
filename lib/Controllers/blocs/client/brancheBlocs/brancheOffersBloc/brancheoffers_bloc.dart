import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techtime/Controllers/Repositories/client/branches/branches_repository.dart';
import 'package:techtime/Models/client/companyData/brancheData/brancheOffers/branche_offers.dart';

part 'brancheoffers_event.dart';
part 'brancheoffers_state.dart';

class BrancheOffersBloc extends Bloc<BrancheOffersEvent, BrancheOffersState> {
  BrancheOffersBloc(this._branchesRepo) : super(BrancheoffersInitial());
  final BranchesRepository _branchesRepo;

  @override
  Stream<BrancheOffersState> mapEventToState(
    BrancheOffersEvent event,
  ) async* {
    if (event is GetBrancheOffers) {
      yield BrancheOffersLoading();
      try {
        final companies = await _branchesRepo.getBrancheOffers(event.branchId);
        yield BrancheOffersSuccess(companies);
      } catch (e) {
        yield BrancheOffersFaild(e.toString());
      }
    }
  }
}
