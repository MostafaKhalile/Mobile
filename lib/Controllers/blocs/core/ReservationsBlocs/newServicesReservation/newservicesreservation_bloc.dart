import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techtime/Controllers/Services/ReservationServices/reservation_service.dart';
import 'package:techtime/Models/Params/create_order_first_step_params.dart';

part 'newservicesreservation_event.dart';
part 'newservicesreservation_state.dart';

class NewservicesreservationBloc
    extends Bloc<NewservicesreservationEvent, NewservicesreservationState> {
  NewservicesreservationBloc(this._servicesReservation)
      : super(NewservicesreservationInitial());
  final ServicesReservation _servicesReservation;
  @override
  Stream<NewservicesreservationState> mapEventToState(
    NewservicesreservationEvent event,
  ) async* {
    if (event is CreateNewServicesOrderFirstStep) {
      try {
        final bool isCreated = await _servicesReservation.createNewOrder(
            event.branchId, event.params);
        if (isCreated) {
          yield NewservicesreservationSuccess();
        }
      } catch (e) {
        print(e.toString());
        yield NewservicesreservationFailure(e.toString());
      }
    }
  }
}
