part of 'wallettransformpromocode_bloc.dart';

abstract class WallettransformpromocodeEvent extends Equatable {
  const WallettransformpromocodeEvent();

  @override
  List<Object> get props => [];
}

class WalletTranseferePromocode extends WallettransformpromocodeEvent {
  final String promocode;

  WalletTranseferePromocode(this.promocode);
}
