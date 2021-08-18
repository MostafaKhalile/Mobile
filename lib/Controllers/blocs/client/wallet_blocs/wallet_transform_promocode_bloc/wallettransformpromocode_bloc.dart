import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techtime/Controllers/Repositories/client/Account/repository.dart';

part 'wallettransformpromocode_event.dart';
part 'wallettransformpromocode_state.dart';

class WallettransformpromocodeBloc
    extends Bloc<WallettransformpromocodeEvent, WallettransformpromocodeState> {
  WallettransformpromocodeBloc(this._userRepo)
      : super(WallettransformpromocodeInitial());
  final USerRepo _userRepo;
  @override
  Stream<WallettransformpromocodeState> mapEventToState(
    WallettransformpromocodeEvent event,
  ) async* {
    if (event is WalletTranseferePromocode) {
      yield WallettransformpromocodeLoading();
      try {
        final result =
            await _userRepo.walletTransformPromocode(event.promocode);
        if (result['status'] == 201) {
          yield WallettransformpromocodeSucceded(result['message'].toString());
        } else {
          yield WallettransformpromocodeFailed(result['message'].toString());
        }
      } catch (e) {
        yield WallettransformpromocodeFailed(e.toString());
      }
    }
  }
}
