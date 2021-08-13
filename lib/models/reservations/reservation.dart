import 'package:equatable/equatable.dart';

class Reservation extends Equatable {
  final bool? user;
  final int? orderId;
  final String? orderFrom;
  final String? orderImageFrom;
  final String? orderOrderDate;
  final String? orderOrderTime;
  final int? orderFromTotalOrder;
  final int? orderToTotalOrder;
  final dynamic orderTwoOrderDate;
  final dynamic orderTwoOrderTime;
  final int? orderTotalOrder;
  final int? orderTotalService;
  final String? orderCode;
  final String? orderStatus;

  const Reservation({
    this.user,
    this.orderId,
    this.orderFrom,
    this.orderImageFrom,
    this.orderOrderDate,
    this.orderOrderTime,
    this.orderTwoOrderDate,
    this.orderTwoOrderTime,
    this.orderFromTotalOrder,
    this.orderToTotalOrder,
    this.orderTotalOrder,
    this.orderTotalService,
    this.orderCode,
    this.orderStatus,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) => Reservation(
        user: json['User'] as bool?,
        orderId: json['OrderID'] as int?,
        orderFrom: json['OrderFrom'] as String?,
        orderImageFrom: json['OrderImageFrom'] as String?,
        orderOrderDate: json['OrderOrderDate'] as String?,
        orderOrderTime: json['OrderOrderTime'] as String?,
        orderFromTotalOrder: json['OrderFromTotalOrder'] as int?,
        orderToTotalOrder: json['OrderToTotalOrder'] as int?,
        orderTwoOrderDate: json['OrderTwoOrderDate'],
        orderTwoOrderTime: json['OrderTwoOrderTime'],
        orderTotalOrder: json['OrderTotalOrder'] as int?,
        orderTotalService: json['OrderTotalService'] as int?,
        orderCode: json['OrderCode'] as String?,
        orderStatus: json['OrderStatus'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'User': user,
        'OrderID': orderId,
        'OrderFrom': orderFrom,
        'OrderImageFrom': orderImageFrom,
        'OrderOrderDate': orderOrderDate,
        'OrderOrderTime': orderOrderTime,
        'OrderTwoOrderDate': orderTwoOrderDate,
        'OrderTwoOrderTime': orderTwoOrderTime,
        'OrderFromTotalOrder': orderFromTotalOrder,
        'OrderToTotalOrder': orderToTotalOrder,
        'OrderTotalOrder': orderTotalOrder,
        'OrderTotalService': orderTotalService,
        'OrderCode': orderCode,
        'OrderStatus': orderStatus,
      };

  Reservation copyWith({
    bool? user,
    int? orderId,
    String? orderFrom,
    String? orderImageFrom,
    String? orderOrderDate,
    String? orderOrderTime,
    dynamic orderTwoOrderDate,
    dynamic orderTwoOrderTime,
    int? orderTotalOrder,
    int? orderTotalService,
    String? orderCode,
    String? orderStatus,
  }) {
    return Reservation(
      user: user ?? this.user,
      orderId: orderId ?? this.orderId,
      orderFrom: orderFrom ?? this.orderFrom,
      orderImageFrom: orderImageFrom ?? this.orderImageFrom,
      orderOrderDate: orderOrderDate ?? this.orderOrderDate,
      orderOrderTime: orderOrderTime ?? this.orderOrderTime,
      orderTwoOrderDate: orderTwoOrderDate ?? this.orderTwoOrderDate,
      orderTwoOrderTime: orderTwoOrderTime ?? this.orderTwoOrderTime,
      orderTotalOrder: orderTotalOrder ?? this.orderTotalOrder,
      orderTotalService: orderTotalService ?? this.orderTotalService,
      orderCode: orderCode ?? this.orderCode,
      orderStatus: orderStatus ?? this.orderStatus,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      user,
      orderId,
      orderFrom,
      orderImageFrom,
      orderOrderDate,
      orderOrderTime,
      orderTwoOrderDate,
      orderTwoOrderTime,
      orderTotalOrder,
      orderTotalService,
      orderCode,
      orderStatus,
    ];
  }
}
