import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';

class PreventCloseButton extends StatefulWidget {
  final Widget? child;

  const PreventCloseButton({Key? key, this.child}) : super(key: key);

  @override
  _PreventCloseButtonState createState() => _PreventCloseButtonState();
}

class _PreventCloseButtonState extends State<PreventCloseButton> {
  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(onWillPop: onWillPop, child: widget.child!),
    );
  }

  Future<bool> onWillPop() {
    final DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 5)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          msg: AppLocalizations.of(context)!
              .translate("please_click_again_to_exit")!);
      return Future.value(false);
    }
    return Future.value(true);
  }
}
