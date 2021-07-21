import 'package:equatable/equatable.dart';

class OrderData extends Equatable {
  final bool user;
  final int orderId;
  final bool orderTypeServices;
  final String orderFrom;
  final String orderImageFrom;
  final int branchId;
  final String orderBranch;
  final String orderCode;
  final int orderMobile;
  final String orderAddress;
  final String longitude;
  final String latitude;
  final int employeeId;
  final String employeeImage;
  final String employeeName;
  final dynamic raty;

  const OrderData({
    this.user,
    this.orderId,
    this.orderTypeServices,
    this.orderFrom,
    this.orderImageFrom,
    this.branchId,
    this.orderBranch,
    this.orderCode,
    this.orderMobile,
    this.orderAddress,
    this.longitude,
    this.latitude,
    this.employeeId,
    this.employeeImage,
    this.employeeName,
    this.raty,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
        user: json['User'] as bool,
        orderId: json['OrderID'] as int,
        orderTypeServices: json['OrderTypeServices'] as bool,
        orderFrom: json['OrderFrom'] as String,
        orderImageFrom: json['OrderImageFrom'] as String,
        branchId: json['BranchID'] as int,
        orderBranch: json['OrderBranch'] as String,
        orderCode: json['OrderCode'] as String,
        orderMobile: json['OrderMobile'] as int,
        orderAddress: json['OrderAddress'] as String,
        longitude: json['Longitude'] as String,
        latitude: json['Latitude'] as String,
        employeeId: json['EmployeeID'] as int,
        employeeImage: json['EmployeeImage'] as String,
        employeeName: json['EmployeeName'] as String,
        raty: json['raty'],
      );

  Map<String, dynamic> toJson() => {
        'User': user,
        'OrderID': orderId,
        'OrderTypeServices': orderTypeServices,
        'OrderFrom': orderFrom,
        'OrderImageFrom': orderImageFrom,
        'BranchID': branchId,
        'OrderBranch': orderBranch,
        'OrderCode': orderCode,
        'OrderMobile': orderMobile,
        'OrderAddress': orderAddress,
        'Longitude': longitude,
        'Latitude': latitude,
        'EmployeeID': employeeId,
        'EmployeeImage': employeeImage,
        'EmployeeName': employeeName,
        'raty': raty,
      };

  OrderData copyWith({
    bool user,
    int orderId,
    bool orderTypeServices,
    String orderFrom,
    String orderImageFrom,
    int branchId,
    String orderBranch,
    String orderCode,
    int orderMobile,
    String orderAddress,
    String longitude,
    String latitude,
    int employeeId,
    String employeeImage,
    String employeeName,
    dynamic raty,
  }) {
    return OrderData(
      user: user ?? this.user,
      orderId: orderId ?? this.orderId,
      orderTypeServices: orderTypeServices ?? this.orderTypeServices,
      orderFrom: orderFrom ?? this.orderFrom,
      orderImageFrom: orderImageFrom ?? this.orderImageFrom,
      branchId: branchId ?? this.branchId,
      orderBranch: orderBranch ?? this.orderBranch,
      orderCode: orderCode ?? this.orderCode,
      orderMobile: orderMobile ?? this.orderMobile,
      orderAddress: orderAddress ?? this.orderAddress,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      employeeId: employeeId ?? this.employeeId,
      employeeImage: employeeImage ?? this.employeeImage,
      employeeName: employeeName ?? this.employeeName,
      raty: raty ?? this.raty,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      user,
      orderId,
      orderTypeServices,
      orderFrom,
      orderImageFrom,
      branchId,
      orderBranch,
      orderCode,
      orderMobile,
      orderAddress,
      longitude,
      latitude,
      employeeId,
      employeeImage,
      employeeName,
      raty,
    ];
  }
}
