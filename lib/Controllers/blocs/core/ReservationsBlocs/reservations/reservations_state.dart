part of 'reservations_bloc.dart';

abstract class ReservationsState extends Equatable {
  const ReservationsState();

  @override
  List<Object> get props => [];
}

class ReservationsInitial extends ReservationsState {}

class PreviousReservationsLoading extends ReservationsState {}

class PreviousReservationsSuccess extends ReservationsState {
  final List<Reservation> reservations;

  const PreviousReservationsSuccess(this.reservations);
}

class PreviousReservationsFaild extends ReservationsState {
  final String message;

  const PreviousReservationsFaild(this.message);
}
class UpcomingReservationsLoading extends ReservationsState {}

class UpcomingReservationsSuccess extends ReservationsState {
  final List<Reservation> reservations;

  const UpcomingReservationsSuccess(this.reservations);
}

class UpcomingReservationsFaild extends ReservationsState {
  final String message;

  const UpcomingReservationsFaild(this.message);
}
