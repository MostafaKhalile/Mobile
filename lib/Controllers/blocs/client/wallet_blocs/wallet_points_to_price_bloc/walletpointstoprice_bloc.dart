import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techtime/Controllers/Repositories/client/Account/repository.dart';
import 'package:techtime/Models/client/wallet/wallet_points_to_price.dart';

part 'walletpointstoprice_event.dart';
part 'walletpointstoprice_state.dart';

class WalletpointstopriceBloc
    extends Bloc<WalletpointstopriceEvent, WalletpointstopriceState> {
  WalletpointstopriceBloc(this._userRepo) : super(WalletpointstopriceInitial());
  final USerRepo _userRepo;

  @override
  Stream<WalletpointstopriceState> mapEventToState(
    WalletpointstopriceEvent event,
  ) async* {
    if (event is GetWalletPointsToPrice) {
      yield WalletPointsToPriceLoading();
      try {
        final pointsToPrice = await _userRepo.walletPointsToPrice(event.points);
        if (pointsToPrice.status == 201) {
          yield WalletPointsToPriceSucceded(pointsToPrice);
        } else {
          yield WalletPointsToPriceFailed(pointsToPrice.message.toString());
        }
      } catch (e) {
        yield WalletPointsToPriceFailed(e.toString());
      }
    }
  }
}
