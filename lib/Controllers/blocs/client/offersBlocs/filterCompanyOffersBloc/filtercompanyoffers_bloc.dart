import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techtime/Controllers/Repositories/client/offers/repository.dart';
import 'package:techtime/Models/client/offers/company_offers.dart';

part 'filtercompanyoffers_event.dart';
part 'filtercompanyoffers_state.dart';

class FiltercompanyoffersBloc
    extends Bloc<FiltercompanyoffersEvent, FiltercompanyoffersState> {
  FiltercompanyoffersBloc(this._offersRepo)
      : super(FiltercompanyoffersInitial());
  final OffersRepo _offersRepo;

  @override
  Stream<FiltercompanyoffersState> mapEventToState(
    FiltercompanyoffersEvent event,
  ) async* {
    if (event is FilterCompanyOffers) {
      yield FiltercompanyoffersLoading();
      try {
        final CompanyOffers companyOffers =
            await _offersRepo.filterOffersCompany(event.id);
        yield FiltercompanyoffersSuccess(companyOffers);
        // ignore: empty_catches
      } catch (e) {}
    }
  }
}
