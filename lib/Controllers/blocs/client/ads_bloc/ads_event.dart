part of 'ads_bloc.dart';

abstract class AdsEvent extends Equatable {
  const AdsEvent();

  @override
  List<Object> get props => [];
}

class GetAdsAbove extends AdsEvent {
  const GetAdsAbove();
}
