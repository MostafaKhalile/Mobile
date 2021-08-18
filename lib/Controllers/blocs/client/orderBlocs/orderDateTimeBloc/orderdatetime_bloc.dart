import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techtime/Controllers/Repositories/client/Order/order_repository.dart';
import 'package:techtime/Models/client/orders/order_date_time.dart';

part 'orderdatetime_event.dart';
part 'orderdatetime_state.dart';

class OrderDateTimeBloc extends Bloc<OrderDateTimeEvent, OrderDateTimeState> {
  OrderDateTimeBloc(this._orderRepository) : super(OrderDateTimeInitial());
  final OrdersRepository _orderRepository;

  @override
  Stream<OrderDateTimeState> mapEventToState(
    OrderDateTimeEvent event,
  ) async* {
    if (event is GetOrderDateTimes) {
      yield OrderDateTimeLoading();
      try {
        final List<OrderDateTime> orderDateTimes =
            await _orderRepository.getOrderDateTime(event.branceId);
        yield OrderDateTimeSuccess(orderDateTimes);
      } catch (e) {
        yield OrderDateTimeFaild(e.toString());
      }
    }
  }
}
