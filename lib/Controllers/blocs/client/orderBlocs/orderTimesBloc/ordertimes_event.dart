part of 'ordertimes_bloc.dart';

abstract class OrderTimesEvent extends Equatable {
  const OrderTimesEvent();

  @override
  List<Object> get props => [];
}

class GetDayAvailableTimes extends OrderTimesEvent {
  final List<dynamic> orderTimes;

  const GetDayAvailableTimes(this.orderTimes);
}
