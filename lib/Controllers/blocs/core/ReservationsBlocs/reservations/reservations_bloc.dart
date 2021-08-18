import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techtime/Controllers/Repositories/reservations/reservations_repository.dart';
import 'package:techtime/Models/reservations/reservation.dart';

part 'reservations_event.dart';
part 'reservations_state.dart';

class ReservationsBloc extends Bloc<ReservationsEvent, ReservationsState> {
  ReservationsBloc(this._reservationsRepo) : super(ReservationsInitial());
  final ReservationsRepo _reservationsRepo;
  @override
  Stream<ReservationsState> mapEventToState(
    ReservationsEvent event,
  ) async* {
    if (event is GetPreviousResrvations) {
      yield PreviousReservationsLoading();
      try {
        final List<Reservation>? reservations =
            await _reservationsRepo.getPreviousReservations();
        yield PreviousReservationsSuccess(reservations);
      } catch (e) {
        yield PreviousReservationsFaild(e.toString());
      }
    }

    if (event is GetUpcomingResrvations) {
      yield UpcomingReservationsLoading();
      try {
        final List<Reservation>? reservations =
            await _reservationsRepo.getUpcomingReservations();
        yield UpcomingReservationsSuccess(reservations);
      } catch (e) {
        yield UpcomingReservationsFaild(e.toString());
      }
    }
  }
}
