import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:techtime/Helpers/app_colors.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';

class CustomToast {
  void buildSuccessMessage(BuildContext context) {
    showToastWidget(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
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
        duration: const Duration(seconds: 4),
        animDuration: const Duration(seconds: 1),
        curve: Curves.elasticOut,
        reverseCurve: Curves.linear);
  }

  void buildErrorMessage(BuildContext context, String message) {
    showToastWidget(
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Card(
                elevation: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: defaultPadding, horizontal: 5),
                  child: Wrap(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: AppColors.errorColor,
                        size: 30,
                      ),
                      const SizedBox(
                        width: defaultPadding,
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
        duration: const Duration(seconds: 4),
        animDuration: const Duration(seconds: 1),
        curve: Curves.elasticOut,
        reverseCurve: Curves.linear);
  }
}
