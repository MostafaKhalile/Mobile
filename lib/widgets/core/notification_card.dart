import 'package:flutter/material.dart';
import 'package:techtime/Helpers/app_colors.dart';
import 'package:techtime/Helpers/enums.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Models/notifications/user_notification.dart';

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
    final ThemeData _theme = Theme.of(context);
    final AppLocalizations _translator = AppLocalizations.of(context);
    return Card(
      shape: Border(
          left: BorderSide(
              color: hasBeenRead ? Colors.transparent : AppColors.primaryColor,
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
        trailing: PopupMenuButton<NotificationsActions>(
          icon: const Icon(Icons.more_horiz),
          onSelected: (NotificationsActions result) {
            if (result == NotificationsActions.delete) {
              print("delete");
            }
          },
          itemBuilder: (BuildContext context) =>
              <PopupMenuEntry<NotificationsActions>>[
            PopupMenuItem<NotificationsActions>(
              value: NotificationsActions.read,
              textStyle: _theme.textTheme.subtitle2,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(
                      Icons.check,
                      color: _theme.accentColor,
                    ),
                  ),
                  Text(_translator.translate('mark_as_read')),
                ],
              ),
            ),
            PopupMenuItem<NotificationsActions>(
                value: NotificationsActions.delete,
                textStyle: _theme.textTheme.subtitle2,
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(
                      Icons.delete_forever,
                      color: _theme.accentColor,
                    ),
                  ),
                  Text(_translator.translate('delete')),
                ])),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}
