import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techtime/Controllers/Repositories/reservations/reservations_repository.dart';
import 'package:techtime/Models/reservations/reservationDetails/reservation_details.dart';

part 'reservationdetails_event.dart';
part 'reservationdetails_state.dart';

class ReservationdetailsBloc
    extends Bloc<ReservationdetailsEvent, ReservationdetailsState> {
  ReservationdetailsBloc(this._reservationsRepo)
      : super(ReservationdetailsInitial());
  final ReservationsRepo _reservationsRepo;

  @override
  Stream<ReservationdetailsState> mapEventToState(
    ReservationdetailsEvent event,
  ) async* {
    if (event is GetReservationDetails) {
      yield ReservationdetailsLaoding();
      try {
        final ReservationDetails reservationDetails =
            await _reservationsRepo.getReservationDetails(event.reservationId);
        yield ReservationdetailsSuccess(reservationDetails);
      } catch (e) {
        yield ReservationdetailsFaild(e.toString());
      }
    }
  }
}
