import 'package:equatable/equatable.dart';

class WalletTotalData extends Equatable {
  final int status;
  final dynamic message;
  final double money;
  final int points;
  final double creditor;

  const WalletTotalData({
    this.status,
    this.message,
    this.money,
    this.points,
    this.creditor,
  });

  factory WalletTotalData.fromJson(Map<String, dynamic> json) {
    return WalletTotalData(
      status: json['status'] as int,
      message: json['message'],
      money: json['Money'] as double,
      points: json['Points'] as int,
      creditor: json['Creditor'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'Money': money,
      'Points': points,
      'Creditor': creditor,
    };
  }

  WalletTotalData copyWith({
    int status,
    dynamic message,
    int money,
    int points,
    int creditor,
  }) {
    return WalletTotalData(
      status: status ?? this.status,
      message: message ?? this.message,
      money: money ?? this.money,
      points: points ?? this.points,
      creditor: creditor ?? this.creditor,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [status, message, money, points, creditor];
}
