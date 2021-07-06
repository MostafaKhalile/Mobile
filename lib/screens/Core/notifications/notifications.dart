import 'package:flutter/material.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/enums.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Models/notifications/all_notifications.dart';
import 'package:techtime/Models/notifications/user_notification.dart';
import 'package:techtime/widgets/core/notification_card.dart';

class Notifications extends StatefulWidget {
  static const String routeName = "/notifications";
  final AllNotifications notifications;

  const Notifications({Key key, this.notifications}) : super(key: key);
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    // Size _size = MediaQuery.of(context).size;
    final AppLocalizations _translator = AppLocalizations.of(context);
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          title: Text(
            _translator.translate("notifications"),
            style: _theme.textTheme.headline6.copyWith(color: Colors.black),
          ),
          actionsIconTheme: const IconThemeData(color: Colors.black),
          actions: [
            PopupMenuButton<NotificationsActions>(
              onSelected: (NotificationsActions result) {
                if (result == NotificationsActions.readAll) {
                  print("read All");
                }
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<NotificationsActions>>[
                PopupMenuItem<NotificationsActions>(
                  value: NotificationsActions.readAll,
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
                      Text(_translator.translate('mark_all_as_read')),
                    ],
                  ),
                ),
                PopupMenuItem<NotificationsActions>(
                    value: NotificationsActions.clearAll,
                    textStyle: _theme.textTheme.subtitle2,
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(
                          Icons.delete_forever,
                          color: _theme.accentColor,
                        ),
                      ),
                      Text(_translator.translate('clear_all')),
                    ])),
              ],
            )
          ],
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              // const Align(
              //   alignment: Alignment.topCenter,
              //   child: SizedBox(
              //       height: 5,
              //       child: LinearProgressIndicator(
              //         valueColor: AlwaysStoppedAnimation<Color>(
              //           KDarkGreyColor,
              //         ),
              //         backgroundColor: Colors.black,
              //       )),
              // ),
              Expanded(
                child: ListView.builder(
                    itemCount: widget.notifications.notReadNotification.length +
                        widget.notifications.readNotification.length,
                    padding: const EdgeInsets.all(KDefaultPadding / 2),
                    itemBuilder: (context, index) {
                      final List<UserNotification> notifications =
                          widget.notifications.notReadNotification +
                              widget.notifications.readNotification;
                      final item = notifications[index];

                      return Dismissible(
                          // Each Dismissible must contain a Key. Keys allow Flutter to
                          // uniquely identify widgets.
                          key: Key(item.toString()),
                          // Provide a function that tells the app
                          // what to do after an item has been swiped away.
                          onDismissed: (direction) {
                            // Remove the item from the data source.
                            buildOnDismiss(index, context, item.toString());
                          },
                          confirmDismiss: (direction) {
                            return buildShowDialog(context, _translator);
                          },
                          // Show a red background as the item is swiped away.
                          direction: DismissDirection.startToEnd,
                          background: SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.redAccent,
                                    size: 32,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          child: NotificationCard(
                            hasBeenRead: notifications[index].notificationOpen,
                            notification: notifications[index],
                          ));
                    }),
              ),
            ],
          ),
        ));
  }

  void buildOnDismiss(int index, BuildContext context, String item) {
    //TODO: Implement read notification
    // Remove the item from the data source.
    // setState(() {
    //   notifications.removeAt(index);
    // });

    // // Then show a snackbar.
    // ScaffoldMessenger.of(context)
    //     .showSnackBar(SnackBar(content: Text("$item dismissed")));
  }

  Future<bool> buildShowDialog(
      BuildContext context, AppLocalizations _translator) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(_translator.translate("are_sure_to_delete_object")),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(
                _translator.translate("confirm"),
                style: Theme.of(context).textTheme.button,
              ),
            ),
            TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(
                  _translator.translate("cancel"),
                  style: Theme.of(context).textTheme.button,
                )),
          ],
        );
      },
    );
  }
}
