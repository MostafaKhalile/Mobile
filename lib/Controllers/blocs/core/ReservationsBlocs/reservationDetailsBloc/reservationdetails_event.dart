part of 'reservationdetails_bloc.dart';

abstract class ReservationdetailsEvent extends Equatable {
  const ReservationdetailsEvent();

  @override
  List<Object> get props => [];
}

class GetReservationDetails extends ReservationdetailsEvent {
  final int reservationId;

  const GetReservationDetails(this.reservationId);
}
