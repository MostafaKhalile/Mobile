import 'package:equatable/equatable.dart';
import 'package:techtime/Models/notifications/user_notification.dart';

class AllNotifications extends Equatable {
  final int? status;
  final List<UserNotification>? readNotification;
  final List<UserNotification>? notReadNotification;

  const AllNotifications({
    this.status,
    this.readNotification,
    this.notReadNotification,
  });

  factory AllNotifications.fromJson(Map<String, dynamic> json) =>
      AllNotifications(
        status: json['status'] as int?,
        readNotification: (json['ReadNotification'] as List)
            .map((e) => UserNotification.fromJson(e as Map<String, dynamic>))
            .toList(),
        notReadNotification: (json['NotReadNotification'] as List)
            .map((e) => UserNotification.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'ReadNotification': readNotification,
        'NotReadNotification':
            notReadNotification!.map((e) => e.toJson()).toList(),
      };

  AllNotifications copyWith({
    int? status,
    List<UserNotification>? readNotification,
    List<UserNotification>? notReadNotification,
  }) {
    return AllNotifications(
      status: status ?? this.status,
      readNotification: readNotification ?? this.readNotification,
      notReadNotification: notReadNotification ?? this.notReadNotification,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      status,
      readNotification,
      notReadNotification,
    ];
  }
}
