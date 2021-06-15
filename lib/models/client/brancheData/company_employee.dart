import 'package:equatable/equatable.dart';

class CompanyEmployee extends Equatable {
  final String image;
  final int employeeId;
  final String employeeName;
  final double raty;

  const CompanyEmployee({
    this.image,
    this.employeeId,
    this.employeeName,
    this.raty,
  });

  factory CompanyEmployee.fromJson(Map<String, dynamic> json) {
    return CompanyEmployee(
      image: json['Image'] as String,
      employeeId: json['EmployeeID'] as int,
      employeeName: json['EmployeeName'] as String,
      raty: json['raty'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Image': image,
      'EmployeeID': employeeId,
      'EmployeeName': employeeName,
      'raty': raty,
    };
  }

  CompanyEmployee copyWith({
    String image,
    int employeeId,
    String employeeName,
    int raty,
  }) {
    return CompanyEmployee(
      image: image ?? this.image,
      employeeId: employeeId ?? this.employeeId,
      employeeName: employeeName ?? this.employeeName,
      raty: raty ?? this.raty,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [image, employeeId, employeeName, raty];
}
