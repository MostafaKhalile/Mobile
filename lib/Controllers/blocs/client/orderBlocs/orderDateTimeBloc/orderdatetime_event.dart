part of 'orderdatetime_bloc.dart';

abstract class OrderDateTimeEvent extends Equatable {
  const OrderDateTimeEvent();

  @override
  List<Object> get props => [];
}

class GetOrderDateTimes extends OrderDateTimeEvent {
  final int branceId;
  const GetOrderDateTimes(this.branceId);
}
