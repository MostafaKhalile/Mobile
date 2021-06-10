part of 'wallettransformpoints_bloc.dart';

abstract class WallettransformpointsState extends Equatable {
  const WallettransformpointsState();

  @override
  List<Object> get props => [];
}

class WallettransformpointsInitial extends WallettransformpointsState {}

class WallettransformpointsLoading extends WallettransformpointsState {}

class WallettransformpointsSucceded extends WallettransformpointsState {
  final String message;

  WallettransformpointsSucceded(this.message);
}

class WallettransformpointsFailed extends WallettransformpointsState {
  final String message;

  WallettransformpointsFailed(this.message);
}
