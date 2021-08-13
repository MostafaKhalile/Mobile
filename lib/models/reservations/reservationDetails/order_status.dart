import 'package:equatable/equatable.dart';

class OrderStatus extends Equatable {
  final bool? waiting;
  final bool? assent;
  final bool? assentClient;
  final bool? confirm;
  final bool? cancel;
  final bool? done;
  final bool? finish;

  const OrderStatus({
    this.waiting,
    this.assent,
    this.assentClient,
    this.confirm,
    this.cancel,
    this.done,
    this.finish,
  });

  factory OrderStatus.fromJson(Map<String, dynamic> json) => OrderStatus(
        waiting: json['Waiting'] as bool?,
        assent: json['Assent'] as bool?,
        assentClient: json['AssentClient'] as bool?,
        confirm: json['Confirm'] as bool?,
        cancel: json['Cancel'] as bool?,
        done: json['Done'] as bool?,
        finish: json['Finish'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'Waiting': waiting,
        'Assent': assent,
        'AssentClient': assentClient,
        'Confirm': confirm,
        'Cancel': cancel,
        'Done': done,
        'Finish': finish,
      };

  OrderStatus copyWith({
    bool? waiting,
    bool? assent,
    bool? assentClient,
    bool? confirm,
    bool? cancel,
    bool? done,
    bool? finish,
  }) {
    return OrderStatus(
      waiting: waiting ?? this.waiting,
      assent: assent ?? this.assent,
      assentClient: assentClient ?? this.assentClient,
      confirm: confirm ?? this.confirm,
      cancel: cancel ?? this.cancel,
      done: done ?? this.done,
      finish: finish ?? this.finish,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      waiting,
      assent,
      assentClient,
      confirm,
      cancel,
      done,
      finish,
    ];
  }
}
