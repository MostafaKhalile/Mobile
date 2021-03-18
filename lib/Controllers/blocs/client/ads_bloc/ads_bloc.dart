import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techtime/Controllers/repositories/client/home/user_home_repo.dart';
import 'package:techtime/models/client/advertise.dart';

part 'ads_event.dart';
part 'ads_state.dart';

class AdsBloc extends Bloc<AdsEvent, AdsState> {
  final APIClientHomeRepository _clientHomeRepo;

  AdsBloc(this._clientHomeRepo) : super(AdsInitial());

  @override
  Stream<AdsState> mapEventToState(
    AdsEvent event,
  ) async* {
    if (event is GetAdsAbove) {
      try {
        yield AdsLoading();
        final ads = await _clientHomeRepo.fetchAdsAbove;
        yield AdsLoaded(ads);
      } catch (e) {
        yield AdsError(e.toString());
      }
    }
  }
}
