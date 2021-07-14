import 'package:equatable/equatable.dart';

class UserNotification extends Equatable {
  final int notificationId;
  final String notificationNotesAr;
  final String notificationNotesEn;
  final bool notificationOpen;
  final bool forOrder;
  final int getOrderId;
  final bool forBranche;
  final dynamic getBrancheId;
  final bool notificationView3;
  final String notificationDate;
  final String notificationTime;

  const UserNotification({
    this.notificationId,
    this.notificationNotesAr,
    this.notificationNotesEn,
    this.notificationOpen,
    this.forOrder,
    this.getOrderId,
    this.forBranche,
    this.getBrancheId,
    this.notificationView3,
    this.notificationDate,
    this.notificationTime,
  });

  factory UserNotification.fromJson(Map<String, dynamic> json) =>
      UserNotification(
        notificationId: json['NotificationID'] as int,
        notificationNotesAr: json['NotificationNotesAR'] as String,
        notificationNotesEn: json['NotificationNotesEN'] as String,
        notificationOpen: json['NotificationOpen'] as bool,
        forOrder: json['ForOrder'] as bool,
        getOrderId: json['GETOrderId'] as int,
        forBranche: json['ForBranche'] as bool,
        getBrancheId: json['GETBrancheId'],
        notificationView3: json['NotificationView3'] as bool,
        notificationDate: json['NotificationDate'] as String,
        notificationTime: json['NotificationTime'] as String,
      );

  Map<String, dynamic> toJson() => {
        'NotificationID': notificationId,
        'NotificationNotesAR': notificationNotesAr,
        'NotificationNotesEN': notificationNotesEn,
        'NotificationOpen': notificationOpen,
        'ForOrder': forOrder,
        'GETOrderId': getOrderId,
        'ForBranche': forBranche,
        'GETBrancheId': getBrancheId,
        'NotificationView3': notificationView3,
        'NotificationDate': notificationDate,
        'NotificationTime': notificationTime,
      };

  UserNotification copyWith({
    int notificationId,
    String notificationNotesAr,
    String notificationNotesEn,
    bool notificationOpen,
    bool forOrder,
    int getOrderId,
    bool forBranche,
    dynamic getBrancheId,
    bool notificationView3,
    String notificationDate,
    String notificationTime,
  }) {
    return UserNotification(
      notificationId: notificationId ?? this.notificationId,
      notificationNotesAr: notificationNotesAr ?? this.notificationNotesAr,
      notificationNotesEn: notificationNotesEn ?? this.notificationNotesEn,
      notificationOpen: notificationOpen ?? this.notificationOpen,
      forOrder: forOrder ?? this.forOrder,
      getOrderId: getOrderId ?? this.getOrderId,
      forBranche: forBranche ?? this.forBranche,
      getBrancheId: getBrancheId ?? this.getBrancheId,
      notificationView3: notificationView3 ?? this.notificationView3,
      notificationDate: notificationDate ?? this.notificationDate,
      notificationTime: notificationTime ?? this.notificationTime,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      notificationId,
      notificationNotesAr,
      notificationNotesEn,
      notificationOpen,
      forOrder,
      getOrderId,
      forBranche,
      getBrancheId,
      notificationView3,
      notificationDate,
      notificationTime,
    ];
  }
}
