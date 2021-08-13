import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techtime/Controllers/Repositories/client/Account/repository.dart';
import 'package:techtime/Models/client/wallet/wallet_total_data.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc(this._userRepo) : super(WalletInitial());
  final USerRepo _userRepo;

  @override
  Stream<WalletState> mapEventToState(
    WalletEvent event,
  ) async* {
    if (event is GetWalletTotalDate) {
      yield WalletTotalDataLoading();
      try {
        final result = await _userRepo.getWalletTotalData();

        yield WalletTotalDataSucceded(result);
      } catch (e) {
        print(e.toString());
        yield WalletTotalDataFailed(e.toString());
      }
    }
  }
}
