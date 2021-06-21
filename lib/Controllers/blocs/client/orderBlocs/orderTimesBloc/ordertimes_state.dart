part of 'ordertimes_bloc.dart';

abstract class OrderTimesState extends Equatable {
  const OrderTimesState();

  @override
  List<Object> get props => [];
}

class OrderTimesInitial extends OrderTimesState {}

class OrderTimesLoading extends OrderTimesState {}

class OrderTimesSuccess extends OrderTimesState {
  final List<TimeOfDay> orderTimes;

  OrderTimesSuccess(this.orderTimes);
}

class OrderTimesFaild extends OrderTimesState {
  final String message;

  OrderTimesFaild(this.message);
}
