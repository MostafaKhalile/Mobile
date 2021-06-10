part of 'walletpointstoprice_bloc.dart';

abstract class WalletpointstopriceState extends Equatable {
  const WalletpointstopriceState();
  
  @override
  List<Object> get props => [];
}

class WalletpointstopriceInitial extends WalletpointstopriceState {}
class WalletPointsToPriceLoading extends WalletpointstopriceState {}

class WalletPointsToPriceSucceded extends WalletpointstopriceState {
  final WalletPointsToPrice walletTotal;

  WalletPointsToPriceSucceded(this.walletTotal);
}

class WalletPointsToPriceFailed extends WalletpointstopriceState {
  final String message;

  WalletPointsToPriceFailed(this.message);
}
