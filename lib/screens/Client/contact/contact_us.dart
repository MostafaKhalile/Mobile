import 'package:flutter/material.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';

import 'components/body.dart';

class ContactUS extends StatelessWidget {
  static const String routeName = "/contact_us";
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final AppLocalizations _translator = AppLocalizations.of(context);
    // ThemeData _theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          _translator.translate("contact_us"),
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.black),
        ),
      ),
      body: SizedBox(
          width: _size.width,
          height: _size.height,
          child: SingleChildScrollView(
            child: Body(),
          )),
    );
  }
}
