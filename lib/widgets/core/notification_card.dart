import 'package:flutter/material.dart';
import 'package:techtime/Helpers/colors.dart';
import 'package:techtime/Models/user_notification.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    Key key,
    @required this.hasBeenRead,
    this.notification,
  }) : super(key: key);
  final UserNotification notification;
  final bool hasBeenRead;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: Border(
          left: BorderSide(
              color: hasBeenRead ? Colors.transparent : KPrimaryColor,
              width: 8)),
      child: ListTile(
        // leading: CircleAvatarProfile(),
        subtitle: Text(notification.notificationNotesEn ?? ""),
        title: RichText(
          text: TextSpan(
            text: notification.notificationDate,
            style: Theme.of(context).textTheme.subtitle1,
            children: <TextSpan>[
              TextSpan(
                text: TimeOfDay(
                        hour: int.parse(notification.notificationTime
                            .toString()
                            .split(":")[0]),
                        minute: int.parse(notification.notificationTime
                            .toString()
                            .split(":")[1]))
                    .format(context),
              )
            ],
          ),
        ),
        trailing: Icon(Icons.more_horiz),
        isThreeLine: true,
      ),
    );
  }
}
