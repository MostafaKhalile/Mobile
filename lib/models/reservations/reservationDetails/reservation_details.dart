import 'package:equatable/equatable.dart';

import 'order_data.dart';
import 'order_info.dart';
import 'order_raty.dart';
import 'order_service.dart';
import 'order_status.dart';

class ReservationDetails extends Equatable {
  final OrderData orderData;
  final List<OrderService> orderService;
  final List<dynamic> orderOffer;
  final OrderInfo orderInfo;
  final OrderStatus orderStatus;
  final List<OrderRaty> orderRaty;

  const ReservationDetails({
    this.orderData,
    this.orderService,
    this.orderOffer,
    this.orderInfo,
    this.orderStatus,
    this.orderRaty,
  });

  factory ReservationDetails.fromJson(Map<String, dynamic> json) =>
      ReservationDetails(
        orderData: json['OrderData'] == null
            ? null
            : OrderData.fromJson(json['OrderData'] as Map<String, dynamic>),
        orderService: (json['OrderService'] as List<dynamic>)
            ?.map((e) => OrderService.fromJson(e as Map<String, dynamic>))
            ?.toList(),
        orderOffer: json['OrderOffer'] as List<dynamic>,
        orderInfo: json['OrderInfo'] == null
            ? null
            : OrderInfo.fromJson(json['OrderInfo'] as Map<String, dynamic>),
        orderStatus: json['OrderStatus'] == null
            ? null
            : OrderStatus.fromJson(json['OrderStatus'] as Map<String, dynamic>),
        orderRaty: (json['OrderRaty'] as List<dynamic>)
            ?.map((e) => OrderRaty.fromJson(e as Map<String, dynamic>))
            ?.toList(),
      );

  Map<String, dynamic> toJson() => {
        'OrderData': orderData?.toJson(),
        'OrderService': orderService?.map((e) => e.toJson())?.toList(),
        'OrderOffer': orderOffer,
        'OrderInfo': orderInfo?.toJson(),
        'OrderStatus': orderStatus?.toJson(),
        'OrderRaty': orderRaty?.map((e) => e.toJson())?.toList(),
      };

  ReservationDetails copyWith({
    OrderData orderData,
    List<OrderService> orderService,
    List<dynamic> orderOffer,
    OrderInfo orderInfo,
    OrderStatus orderStatus,
    List<OrderRaty> orderRaty,
  }) {
    return ReservationDetails(
      orderData: orderData ?? this.orderData,
      orderService: orderService ?? this.orderService,
      orderOffer: orderOffer ?? this.orderOffer,
      orderInfo: orderInfo ?? this.orderInfo,
      orderStatus: orderStatus ?? this.orderStatus,
      orderRaty: orderRaty ?? this.orderRaty,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      orderData,
      orderService,
      orderOffer,
      orderInfo,
      orderStatus,
      orderRaty,
    ];
  }
}
