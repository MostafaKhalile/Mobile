part of 'orderdatetime_bloc.dart';

abstract class OrderDateTimeState extends Equatable {
  const OrderDateTimeState();

  @override
  List<Object> get props => [];
}

class OrderDateTimeInitial extends OrderDateTimeState {}

class OrderDateTimeLoading extends OrderDateTimeState {}

class OrderDateTimeSuccess extends OrderDateTimeState {
  final List<OrderDateTime> orderDateTimes;

  OrderDateTimeSuccess(this.orderDateTimes);
}

class OrderDateTimeFaild extends OrderDateTimeState {
  final String message;

  OrderDateTimeFaild(this.message);
}
