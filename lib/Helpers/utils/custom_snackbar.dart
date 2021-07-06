import 'package:flutter/material.dart';
import 'package:techtime/Helpers/app_colors.dart';

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
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      message,
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
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
        ),
        duration: const Duration(seconds: 5),
        backgroundColor: AppColors.errorColor));
  }
}
