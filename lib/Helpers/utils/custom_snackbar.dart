import 'package:flutter/material.dart';
import 'package:techtime/Helpers/colors.dart';

class Snackbar {
  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
                ClipRRect(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      message,
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
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
