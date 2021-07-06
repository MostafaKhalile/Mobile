part of 'ads_bloc.dart';

abstract class AdsState extends Equatable {
  const AdsState();

  @override
  List<Object> get props => [];
}

class AdsInitial extends AdsState {}

class AdsLoading extends AdsState {
  const AdsLoading();
}

class AdsLoaded extends AdsState {
  final List<Advertise> ads;
  const AdsLoaded(this.ads);
}

class AdsError extends AdsState {
  final String message;
  const AdsError(this.message);
}
