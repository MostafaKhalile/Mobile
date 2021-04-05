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
        content: Container(
          child: Wrap(children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  message,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ))
          ]),
        ),
        duration: Duration(seconds: 5),
        backgroundColor: KErrorColor));
  }
}
