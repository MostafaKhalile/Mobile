part of 'wallettransformpoints_bloc.dart';

abstract class WallettransformpointsEvent extends Equatable {
  const WallettransformpointsEvent();

  @override
  List<Object> get props => [];
}

class WalletTranseferePoints extends WallettransformpointsEvent {
  final String points;

  WalletTranseferePoints(this.points);
}
