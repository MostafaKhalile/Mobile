import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'ordertimes_event.dart';
part 'ordertimes_state.dart';

class OrderTimesBloc extends Bloc<OrderTimesEvent, OrderTimesState> {
  OrderTimesBloc() : super(OrderTimesInitial());

  @override
  Stream<OrderTimesState> mapEventToState(
    OrderTimesEvent event,
  ) async* {
    if (event is GetDayAvailableTimes) {
      yield OrderTimesLoading();
      try {
        final List<TimeOfDay> timeIntervals = getTimePeriods(event.orderTimes);
        yield OrderTimesSuccess(timeIntervals);
      // ignore: empty_catches
      } catch (e) {}
    }
  }

  List<TimeOfDay> getTimePeriods(List<dynamic> times) {
    final List<TimeOfDay> intervals = times
        .map((e) => TimeOfDay(
            hour: int.parse(e.toString().split(":")[0]),
            minute: int.parse(e.toString().split(":")[1])))
        .toList();

    return intervals;
  }
}
