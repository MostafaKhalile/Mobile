import 'package:equatable/equatable.dart';

class OrderInfo extends Equatable {
  final int totalService;
  final int orderFromTotal;
  final int orderToTotal;
  final int orderTotal;
  final int orderResidual;
  final int orderPaidUp;
  final String orderOrderDate;
  final String orderOrderTime;
  final dynamic orderTwoOrderDate;
  final dynamic orderTwoOrderTime;

  const OrderInfo({
    this.totalService,
    this.orderFromTotal,
    this.orderToTotal,
    this.orderTotal,
    this.orderResidual,
    this.orderPaidUp,
    this.orderOrderDate,
    this.orderOrderTime,
    this.orderTwoOrderDate,
    this.orderTwoOrderTime,
  });

  factory OrderInfo.fromJson(Map<String, dynamic> json) => OrderInfo(
        totalService: json['TotalService'] as int,
        orderFromTotal: json['OrderFromTotal'] as int,
        orderToTotal: json['OrderToTotal'] as int,
        orderTotal: json['OrderTotal'] as int,
        orderResidual: json['OrderResidual'] as int,
        orderPaidUp: json['OrderPaidUp'] as int,
        orderOrderDate: json['OrderOrderDate'] as String,
        orderOrderTime: json['OrderOrderTime'] as String,
        orderTwoOrderDate: json['OrderTwoOrderDate'],
        orderTwoOrderTime: json['OrderTwoOrderTime'],
      );

  Map<String, dynamic> toJson() => {
        'TotalService': totalService,
        'OrderFromTotal': orderFromTotal,
        'OrderToTotal': orderToTotal,
        'OrderTotal': orderTotal,
        'OrderResidual': orderResidual,
        'OrderPaidUp': orderPaidUp,
        'OrderOrderDate': orderOrderDate,
        'OrderOrderTime': orderOrderTime,
        'OrderTwoOrderDate': orderTwoOrderDate,
        'OrderTwoOrderTime': orderTwoOrderTime,
      };

  OrderInfo copyWith({
    int totalService,
    int orderFromTotal,
    int orderToTotal,
    int orderTotal,
    int orderResidual,
    int orderPaidUp,
    String orderOrderDate,
    String orderOrderTime,
    dynamic orderTwoOrderDate,
    dynamic orderTwoOrderTime,
  }) {
    return OrderInfo(
      totalService: totalService ?? this.totalService,
      orderFromTotal: orderFromTotal ?? this.orderFromTotal,
      orderToTotal: orderToTotal ?? this.orderToTotal,
      orderTotal: orderTotal ?? this.orderTotal,
      orderResidual: orderResidual ?? this.orderResidual,
      orderPaidUp: orderPaidUp ?? this.orderPaidUp,
      orderOrderDate: orderOrderDate ?? this.orderOrderDate,
      orderOrderTime: orderOrderTime ?? this.orderOrderTime,
      orderTwoOrderDate: orderTwoOrderDate ?? this.orderTwoOrderDate,
      orderTwoOrderTime: orderTwoOrderTime ?? this.orderTwoOrderTime,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      totalService,
      orderFromTotal,
      orderToTotal,
      orderTotal,
      orderResidual,
      orderPaidUp,
      orderOrderDate,
      orderOrderTime,
      orderTwoOrderDate,
      orderTwoOrderTime,
    ];
  }
}
