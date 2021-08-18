part of 'newservicesreservation_bloc.dart';

abstract class NewservicesreservationEvent extends Equatable {
  const NewservicesreservationEvent();

  @override
  List<Object> get props => [];
}

class CreateNewServicesOrderFirstStep extends NewservicesreservationEvent {
  final int branchId;
  final CreateOrderFirstStepParams params;

  const CreateNewServicesOrderFirstStep(this.branchId, this.params);
}

class CreateNewServicesOrderSecondStep extends NewservicesreservationEvent {}
