part of 'wallettransformpoints_bloc.dart';

abstract class WallettransformpointsEvent extends Equatable {
  const WallettransformpointsEvent();

  @override
  List<Object> get props => [];
}

class WalletTranseferePoints extends WallettransformpointsEvent {
  final String points;

  // ignore: prefer_const_constructors_in_immutables
  WalletTranseferePoints(this.points);
}
