import 'package:equatable/equatable.dart';

class CreateOrderFirstStepParams extends Equatable {
  final String? orderDate;
  final String? orderTime;
  final String? employeeRequest;
  final String? totalOrderFrom;
  final String? totalOrderTo;

  const CreateOrderFirstStepParams({
    this.orderDate,
    this.orderTime,
    this.employeeRequest,
    this.totalOrderFrom,
    this.totalOrderTo,
  });

  factory CreateOrderFirstStepParams.fromJson(Map<String, String> json) =>
      CreateOrderFirstStepParams(
        orderDate: json['OrderDate'],
        orderTime: json['OrderTime'],
        employeeRequest: json['EmployeeRequest'],
        totalOrderFrom: json['TotalOrderFrom'],
        totalOrderTo: json['TotalOrderTo'],
      );

  Map<String, String> toJson() => {
        'OrderDate': orderDate.toString(),
        'OrderTime': orderTime.toString(),
        'EmployeeRequest': employeeRequest.toString(),
        'TotalOrderFrom': totalOrderFrom.toString(),
        'TotalOrderTo': totalOrderTo.toString(),
      };

  CreateOrderFirstStepParams copyWith({
    String? orderDate,
    String? orderTime,
    String? employeeRequest,
    String? totalOrderFrom,
    String? totalOrderTo,
  }) {
    return CreateOrderFirstStepParams(
      orderDate: orderDate ?? this.orderDate,
      orderTime: orderTime ?? this.orderTime,
      employeeRequest: employeeRequest ?? this.employeeRequest,
      totalOrderFrom: totalOrderFrom ?? this.totalOrderFrom,
      totalOrderTo: totalOrderTo ?? this.totalOrderTo,
    );
  }

  @override
  List<Object?> get props {
    return [
      orderDate,
      orderTime,
      employeeRequest,
      totalOrderFrom,
      totalOrderTo,
    ];
  }
}
