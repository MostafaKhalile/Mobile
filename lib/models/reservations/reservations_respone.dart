import 'package:equatable/equatable.dart';

import 'reservation.dart';

class ReservationsRespone extends Equatable {
  final int status;
  final dynamic message;
  final List<Reservation> listReservations;

  const ReservationsRespone({
    this.status,
    this.message,
    this.listReservations,
  });

  factory ReservationsRespone.fromJson(Map<String, dynamic> json) =>
      ReservationsRespone(
        status: json['status'] as int,
        message: json['message'] as String,
        listReservations: (json['ListNotification'] as List<dynamic>)
            .map((e) => Reservation.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'ListNotification': listReservations.map((e) => e.toJson()).toList(),
      };

  ReservationsRespone copyWith({
    int status,
    dynamic message,
    List<Reservation> listNotification,
  }) {
    return ReservationsRespone(
      status: status ?? this.status,
      message: message ?? this.message,
      listReservations: listNotification ?? listNotification,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [status, message, listReservations];
}
