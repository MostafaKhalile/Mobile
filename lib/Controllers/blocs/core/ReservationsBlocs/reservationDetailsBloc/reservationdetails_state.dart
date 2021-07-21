part of 'reservationdetails_bloc.dart';

abstract class ReservationdetailsState extends Equatable {
  const ReservationdetailsState();

  @override
  List<Object> get props => [];
}

class ReservationdetailsInitial extends ReservationdetailsState {}

class ReservationdetailsLaoding extends ReservationdetailsState {}

class ReservationdetailsSuccess extends ReservationdetailsState {
  final ReservationDetails reservationDetails;

  const ReservationdetailsSuccess(this.reservationDetails);
}

class ReservationdetailsFaild extends ReservationdetailsState {
  final String message;

  const ReservationdetailsFaild(this.message);
}
