part of 'newservicesreservation_bloc.dart';

abstract class NewservicesreservationState extends Equatable {
  const NewservicesreservationState();

  @override
  List<Object> get props => [];
}

class NewservicesreservationInitial extends NewservicesreservationState {}

class NewservicesreservationSuccess extends NewservicesreservationState {
  final CreateNewOrderResponse response;

  const NewservicesreservationSuccess(this.response);
}

class NewservicesreservationFailure extends NewservicesreservationState {
  final String failure;

  const NewservicesreservationFailure(this.failure);
}

class ServicesReservationSecondStepSuccess extends NewservicesreservationState {
}

class ServicesReservationSecondStepFailure extends NewservicesreservationState {
  final String message;

  const ServicesReservationSecondStepFailure(this.message);
}
