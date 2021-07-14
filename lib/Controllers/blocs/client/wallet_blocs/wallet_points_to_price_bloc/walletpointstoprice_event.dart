part of 'walletpointstoprice_bloc.dart';

abstract class WalletpointstopriceEvent extends Equatable {
  const WalletpointstopriceEvent();

  @override
  List<Object> get props => [];
}

class GetWalletPointsToPrice extends WalletpointstopriceEvent {
  final String points;

  const GetWalletPointsToPrice(this.points);
}
