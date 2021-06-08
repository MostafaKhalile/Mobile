import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';

import '../colors.dart';

class CustomToast {
  void buildSuccessMessage(BuildContext context) {
    showToastWidget(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Colors.greenAccent,
              size: 30,
            ),
            Text(
              AppLocalizations.of(context).translate("edited_successfully"),
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
        context: context,
        position: StyledToastPosition.center,
        dismissOtherToast: true,
        isHideKeyboard: true,
        animation: StyledToastAnimation.scale,
        reverseAnimation: StyledToastAnimation.fade,
        duration: Duration(seconds: 4),
        animDuration: Duration(seconds: 1),
        curve: Curves.elasticOut,
        reverseCurve: Curves.linear);
  }

  void buildErrorMessage(BuildContext context, String message) {
    showToastWidget(
        Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Card(
                elevation: 10,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: KDefaultPadding, horizontal: 5),
                  child: Wrap(
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: KErrorColor,
                        size: 30,
                      ),
                      SizedBox(
                        width: KdefaultPadding,
                      ),
                      Text(
                        message,
                        style: Theme.of(context).textTheme.subtitle2,
                      )
                    ],
                  ),
                ))),
        context: context,
        position: StyledToastPosition.center,
        dismissOtherToast: true,
        isHideKeyboard: true,
        animation: StyledToastAnimation.scale,
        reverseAnimation: StyledToastAnimation.fade,
        duration: Duration(seconds: 4),
        animDuration: Duration(seconds: 1),
        curve: Curves.elasticOut,
        reverseCurve: Curves.linear);
  }
}
