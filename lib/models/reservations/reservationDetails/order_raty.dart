import 'package:equatable/equatable.dart';

class OrderRaty extends Equatable {
  final dynamic companyRaty;
  final dynamic branchRaty;
  final dynamic serviceRaty;
  final dynamic employeeRaty;
  final String? comment;

  const OrderRaty({
    this.companyRaty,
    this.branchRaty,
    this.serviceRaty,
    this.employeeRaty,
    this.comment,
  });

  factory OrderRaty.fromJson(Map<String, dynamic> json) => OrderRaty(
        companyRaty: json['CompanyRaty'],
        branchRaty: json['BranchRaty'],
        serviceRaty: json['ServiceRaty'],
        employeeRaty: json['EmployeeRaty'],
        comment: json['Comment'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'CompanyRaty': companyRaty,
        'BranchRaty': branchRaty,
        'ServiceRaty': serviceRaty,
        'EmployeeRaty': employeeRaty,
        'Comment': comment,
      };

  OrderRaty copyWith({
    dynamic companyRaty,
    dynamic branchRaty,
    dynamic serviceRaty,
    dynamic employeeRaty,
    String? comment,
  }) {
    return OrderRaty(
      companyRaty: companyRaty ?? this.companyRaty,
      branchRaty: branchRaty ?? this.branchRaty,
      serviceRaty: serviceRaty ?? this.serviceRaty,
      employeeRaty: employeeRaty ?? this.employeeRaty,
      comment: comment ?? this.comment,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      companyRaty,
      branchRaty,
      serviceRaty,
      employeeRaty,
      comment,
    ];
  }
}
