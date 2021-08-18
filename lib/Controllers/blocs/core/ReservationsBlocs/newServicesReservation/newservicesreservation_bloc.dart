import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techtime/Controllers/Services/ReservationServices/reservation_service.dart';
import 'package:techtime/Models/Params/create_order_first_step_params.dart';
import 'package:techtime/Models/reservations/create_new_order_response.dart';

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
        final CreateNewOrderResponse response = await _servicesReservation
            .createNewOrder(event.branchId, event.params);
        if (response.orderId != null) {
          yield NewservicesreservationSuccess();
        }
      } catch (e) {
        yield NewservicesreservationFailure(e.toString());
      }
    }
  }
}
