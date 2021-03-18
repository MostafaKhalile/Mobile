import 'package:flutter/material.dart';
import 'package:techtime/Helpers/colors.dart';

class Snackbar {
  void showSnackBar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
        action: SnackBarAction(
          label: '☓',
          textColor: Colors.white,
          onPressed: () {
            // Some code to undo the change.
          },
        ),
        content: Row(
          children: <Widget>[
            Wrap(
              children: <Widget>[
                Text(
                  message,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
        ),
        duration: Duration(seconds: 5),
        backgroundColor: KErrorColor));
  }
}
