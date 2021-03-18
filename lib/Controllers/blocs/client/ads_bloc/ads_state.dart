part of 'ads_bloc.dart';

abstract class AdsState extends Equatable {
  const AdsState();

  @override
  List<Object> get props => [];
}

class AdsInitial extends AdsState {}

class AdsLoading extends AdsState {
  AdsLoading();
}

class AdsLoaded extends AdsState {
  final List<Advertise> ads;
  AdsLoaded(this.ads);
}

class AdsError extends AdsState {
  final String message;
  AdsError(this.message);
}
