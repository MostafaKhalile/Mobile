import 'package:equatable/equatable.dart';

class OrderDateTime extends Equatable {
  final bool open;
  final int n;
  final int ss;
  final String nowTime;
  final String startTime;
  final String startOrder;
  final String startOrderTime;
  final String endOrderTime;
  final String dayAr;
  final String dayEn;
  final int day;
  final int month;
  final String date;
  final List<dynamic> orderTimes;

  const OrderDateTime({
    this.open,
    this.n,
    this.ss,
    this.nowTime,
    this.startTime,
    this.startOrder,
    this.startOrderTime,
    this.endOrderTime,
    this.dayAr,
    this.dayEn,
    this.day,
    this.month,
    this.date,
    this.orderTimes,
  });

  factory OrderDateTime.fromJson(Map<String, dynamic> json) => OrderDateTime(
        open: json['Open'] as bool,
        n: json['N'] as int,
        ss: json['ss'] as int,
        nowTime: json['NowTime'] as String,
        startTime: json['StartTime'] as String,
        startOrder: json['StartOrder'] as String,
        startOrderTime: json['StartOrderTime'] as String,
        endOrderTime: json['EndOrderTime'] as String,
        dayAr: json['DayAR'] as String,
        dayEn: json['DayEN'] as String,
        day: json['Day'] as int,
        month: json['Month'] as int,
        date: json['Date'] as String,
        orderTimes: json['OrderTimes'] as List<dynamic>,
      );

  Map<String, dynamic> toJson() => {
        'Open': open,
        'N': n,
        'ss': ss,
        'NowTime': nowTime,
        'StartTime': startTime,
        'StartOrder': startOrder,
        'StartOrderTime': startOrderTime,
        'EndOrderTime': endOrderTime,
        'DayAR': dayAr,
        'DayEN': dayEn,
        'Day': day,
        'Month': month,
        'Date': date,
        'OrderTimes': orderTimes,
      };

  OrderDateTime copyWith({
    bool open,
    int n,
    int ss,
    String nowTime,
    String startTime,
    String startOrder,
    String startOrderTime,
    String endOrderTime,
    String dayAr,
    String dayEn,
    int day,
    int month,
    String date,
    List<String> orderTimes,
  }) {
    return OrderDateTime(
      open: open ?? this.open,
      n: n ?? this.n,
      ss: ss ?? this.ss,
      nowTime: nowTime ?? this.nowTime,
      startTime: startTime ?? this.startTime,
      startOrder: startOrder ?? this.startOrder,
      startOrderTime: startOrderTime ?? this.startOrderTime,
      endOrderTime: endOrderTime ?? this.endOrderTime,
      dayAr: dayAr ?? this.dayAr,
      dayEn: dayEn ?? this.dayEn,
      day: day ?? this.day,
      month: month ?? this.month,
      date: date ?? this.date,
      orderTimes: orderTimes ?? this.orderTimes,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      open,
      n,
      ss,
      nowTime,
      startTime,
      startOrder,
      startOrderTime,
      endOrderTime,
      dayAr,
      dayEn,
      day,
      month,
      date,
      orderTimes,
    ];
  }
}
