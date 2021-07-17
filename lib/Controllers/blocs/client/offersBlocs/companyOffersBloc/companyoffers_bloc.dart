import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techtime/Controllers/Repositories/client/offers/repository.dart';
import 'package:techtime/Models/client/offers/company_offer.dart';

part 'companyoffers_event.dart';
part 'companyoffers_state.dart';

class CompanyoffersBloc extends Bloc<CompanyoffersEvent, CompanyoffersState> {
  CompanyoffersBloc(this._offersRepo) : super(CompanyoffersInitial());
  final OffersRepo _offersRepo;

  @override
  Stream<CompanyoffersState> mapEventToState(
    CompanyoffersEvent event,
  ) async* {
    if (event is GetCompanyOffers) {
      yield CompanyoffersLoading();
      try {
        final List<CompanyOffer> companyOffers =
            await _offersRepo.getAllCompaniesOffers();
        yield CompanyoffersSuccess(companyOffers);
      } catch (e) {
        print(e.toString());
        yield CompanyoffersFaild(e.toString());
      }
    }
  }
}
