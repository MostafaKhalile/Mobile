import 'package:equatable/equatable.dart';

class WalletPointsToPrice extends Equatable {
  final int status;
  final dynamic message;
  final double money;

  const WalletPointsToPrice({
    this.status,
    this.message,
    this.money,
  });

  factory WalletPointsToPrice.fromJson(Map<String, dynamic> json) {
    return WalletPointsToPrice(
      status: json['status'] as int,
      message: json['message'],
      money: json['Money'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'Money': money,
    };
  }

  WalletPointsToPrice copyWith({
    int status,
    dynamic message,
    double money,
  }) {
    return WalletPointsToPrice(
      status: status ?? this.status,
      message: message ?? this.message,
      money: money ?? this.money,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [status, message, money];
}
