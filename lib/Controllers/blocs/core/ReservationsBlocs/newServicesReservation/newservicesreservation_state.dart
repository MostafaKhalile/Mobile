part of 'newservicesreservation_bloc.dart';

abstract class NewservicesreservationState extends Equatable {
  const NewservicesreservationState();

  @override
  List<Object> get props => [];
}

class NewservicesreservationInitial extends NewservicesreservationState {}

class NewservicesreservationSuccess extends NewservicesreservationState {}

class NewservicesreservationFailure extends NewservicesreservationState {
  final String failure;

  const NewservicesreservationFailure(this.failure);
}
