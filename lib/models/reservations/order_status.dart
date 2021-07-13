import 'package:equatable/equatable.dart';

class OrderStatus extends Equatable {
  final bool waiting;
  final bool confirmed;
  final bool assent;

  const OrderStatus({this.waiting, this.confirmed, this.assent});

  factory OrderStatus.fromJson(Map<String, dynamic> json) => OrderStatus(
        waiting: json['Waiting'] as bool,
        confirmed: json['Confirmed'] as bool,
        assent: json['Assent'] as bool,
      );

  Map<String, dynamic> toJson() => {
        'Waiting': waiting,
        'Confirmed': confirmed,
        'Assent': assent,
      };

  OrderStatus copyWith({
    bool waiting,
    bool confirmed,
    bool assent,
  }) {
    return OrderStatus(
      waiting: waiting ?? this.waiting,
      confirmed: confirmed ?? this.confirmed,
      assent: assent ?? this.assent,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [waiting, confirmed, assent];
}
