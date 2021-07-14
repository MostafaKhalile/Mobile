part of 'reservations_bloc.dart';

abstract class ReservationsEvent extends Equatable {
  const ReservationsEvent();

  @override
  List<Object> get props => [];
}

class GetPreviousResrvations extends ReservationsEvent {}
class GetUpcomingResrvations extends ReservationsEvent {}
