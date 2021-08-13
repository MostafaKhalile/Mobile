import 'package:equatable/equatable.dart';

class CreateNewOrderResponse extends Equatable {
  final int? status;
  final int? orderId;
  final dynamic message;

  const CreateNewOrderResponse({this.status, this.orderId, this.message});

  factory CreateNewOrderResponse.fromJson(Map<String, dynamic> json) =>
      CreateNewOrderResponse(
        status: json['status'] as int?,
        orderId: json['OrderID'] as int?,
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'OrderID': orderId,
        'message': message,
      };

  CreateNewOrderResponse copyWith({
    int? status,
    int? orderId,
    dynamic message,
  }) {
    return CreateNewOrderResponse(
      status: status ?? this.status,
      orderId: orderId ?? this.orderId,
      message: message ?? this.message,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [status, orderId, message];
}
