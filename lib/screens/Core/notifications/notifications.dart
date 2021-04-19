import 'package:flutter/material.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/widgets/core/notification_card.dart';

final items = List<String>.generate(15, (i) => "Item ${i + 1}");

class Notifications extends StatefulWidget {
  static const String routeName = "/notifications";

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
            itemCount: items.length,
            padding: EdgeInsets.all(KDefaultPadding / 2),
            itemBuilder: (context, index) {
              final item = items[index];

              return Dismissible(
                  // Each Dismissible must contain a Key. Keys allow Flutter to
                  // uniquely identify widgets.
                  key: Key(item),
                  // Provide a function that tells the app
                  // what to do after an item has been swiped away.
                  onDismissed: (direction) {
                    // Remove the item from the data source.
                    buildOnDismiss(index, context, item);
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
                  child:
                      NotificationCard(hasBeenRead: index < 2 ? false : true));
            }));
  }

  void buildOnDismiss(int index, BuildContext context, String item) {
    // Remove the item from the data source.
    setState(() {
      items.removeAt(index);
    });

    // Then show a snackbar.
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("$item dismissed")));
  }

  Future<bool> buildShowDialog(
      BuildContext context, AppLocalizations _translator) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(_translator.translate("are_sure_to_delete_object")),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                // ignore: deprecated_member_use
                OutlineButton(
                  child: Text(
                    _translator.translate("agree"),
                    style: Theme.of(context).textTheme.button,
                  ),
                  onPressed: () => Navigator.pop(context, true),
                ),
                SizedBox(
                  height: 5,
                ),
                // ignore: deprecated_member_use
                OutlineButton(
                  onPressed: () => Navigator.pop(context, false),
                  borderSide: BorderSide(
                    color: Colors.purple,
                  ),
                  shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    _translator.translate("doesn't_agree"),
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
