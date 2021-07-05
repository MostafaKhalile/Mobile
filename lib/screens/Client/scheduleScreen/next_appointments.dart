import 'package:flutter/material.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Widgets/client/order_card.dart';
import 'package:techtime/Widgets/core/vertical_gab.dart';
import 'package:techtime/widgets/appointment_card.dart';

final items = List<String>.generate(6, (i) => "Item ${i + 1}");

class NextAppointments extends StatefulWidget {
  @override
  NextAppointmentsState createState() => NextAppointmentsState();
}

class NextAppointmentsState extends State<NextAppointments> {
  @override
  Widget build(BuildContext context) {
    AppLocalizations _translator = AppLocalizations.of(context);
    ThemeData _theme = Theme.of(context);

    return Scaffold(
      body: ListView.separated(
        itemCount: items.length,
        padding: EdgeInsets.symmetric(vertical: KdefaultPadding),
        physics: BouncingScrollPhysics(),
        separatorBuilder: (_, i) => VerticalGap(),
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
                color: Colors.redAccent.withOpacity(0.2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _translator.translate("cancel"),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              child: OrderCard(
                statusCode: 40,
              ));
        },
      ),
    );
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
          title: Text(_translator.translate("are_sure_to_cancel_appointment")),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                // ignore: deprecated_member_use
                RaisedButton(
                  child: Text(
                    _translator.translate("cancel"),
                    style: Theme.of(context).textTheme.button,
                  ),
                  onPressed: () => Navigator.pop(context, true),
                ),
                SizedBox(
                  height: 5,
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                  child: Text(
                    _translator.translate("confirm"),
                    style: Theme.of(context).textTheme.button,
                  ),
                  onPressed: () => Navigator.pop(context, false),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
