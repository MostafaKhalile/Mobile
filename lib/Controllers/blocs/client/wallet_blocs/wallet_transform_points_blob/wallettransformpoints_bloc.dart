import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techtime/Controllers/Repositories/client/Account/repository.dart';

part 'wallettransformpoints_event.dart';
part 'wallettransformpoints_state.dart';

class WallettransformpointsBloc
    extends Bloc<WallettransformpointsEvent, WallettransformpointsState> {
  WallettransformpointsBloc(this._userRepo)
      : super(WallettransformpointsInitial());
  final USerRepo _userRepo;
  @override
  Stream<WallettransformpointsState> mapEventToState(
    WallettransformpointsEvent event,
  ) async* {
    if (event is WalletTranseferePoints) {
      yield WallettransformpointsLoading();
      try {
        final result = await _userRepo.walletTransformPoints(event.points);
        if (result['status'] == 201) {
          yield WallettransformpointsSucceded(result['message']);
        } else {
          yield WallettransformpointsFailed(result['message'].toString());
        }
      } catch (e) {
        print(e.toString());
        yield WallettransformpointsFailed(e.toString());
      }
    }
  }
}
