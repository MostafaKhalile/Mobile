import 'package:flutter/material.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';

class BranchServices extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppLocalizations _translator = AppLocalizations.of(context);

    return Container(
      child: Center(
          child: Text(
        _translator.translate("services"),
        style: Theme.of(context).textTheme.headline6,
      )),
    );
  }
}
