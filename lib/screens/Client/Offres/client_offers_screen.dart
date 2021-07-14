import 'package:flutter/material.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';

class ClientOffersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppLocalizations _translator = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _translator.translate("offers"),
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.black),
        ),
        leading: Container(),
      ),
    );
  }
}
