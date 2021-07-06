import 'package:flutter/material.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Models/notifications/user_notification.dart';
import 'package:techtime/widgets/core/notification_card.dart';

class Notifications extends StatefulWidget {
  static const String routeName = "/notifications";
  final List<UserNotification> notifications;

  const Notifications({Key key, this.notifications}) : super(key: key);
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    // Size _size = MediaQuery.of(context).size;
    AppLocalizations _translator = AppLocalizations.of(context);
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            _translator.translate("notifications"),
            style: _theme.textTheme.headline6.copyWith(color: Colors.black),
          ),
        ),
        body: ListView.builder(
            itemCount: widget.notifications.length,
            padding: EdgeInsets.all(KDefaultPadding / 2),
            itemBuilder: (context, index) {
              final item = widget.notifications[index];

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
                  confirmDismiss: (direction) async {
                    return await buildShowDialog(context, _translator);
                  },
                  // Show a red background as the item is swiped away.
                  background: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
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
                    hasBeenRead: widget.notifications[index].notificationOpen,
                    notification: widget.notifications[index],
                  ));
            }));
  }

  void buildOnDismiss(int index, BuildContext context, String item) {
    // Remove the item from the data source.
    setState(() {
      widget.notifications.removeAt(index);
    });

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
              child: Text(
                _translator.translate("confirm"),
                style: Theme.of(context).textTheme.button,
              ),
              onPressed: () => Navigator.pop(context, true),
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
