part of 'wallettransformpromocode_bloc.dart';

abstract class WallettransformpromocodeState extends Equatable {
  const WallettransformpromocodeState();

  @override
  List<Object> get props => [];
}

class WallettransformpromocodeInitial extends WallettransformpromocodeState {}

class WallettransformpromocodeLoading extends WallettransformpromocodeState {}

class WallettransformpromocodeSucceded extends WallettransformpromocodeState {
  final String message;

  WallettransformpromocodeSucceded(this.message);
}

class WallettransformpromocodeFailed extends WallettransformpromocodeState {
  final String message;

  WallettransformpromocodeFailed(this.message);
}
