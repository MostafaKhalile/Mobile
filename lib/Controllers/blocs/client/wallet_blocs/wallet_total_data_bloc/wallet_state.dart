part of 'wallet_bloc.dart';

abstract class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object> get props => [];
}

class WalletInitial extends WalletState {}

class WalletTotalDataLoading extends WalletState {}

class WalletTotalDataSucceded extends WalletState {
  final WalletTotalData walletTotal;

  const WalletTotalDataSucceded(this.walletTotal);
}

class WalletTotalDataFailed extends WalletState {
  final String message;

  const WalletTotalDataFailed(this.message);
}
