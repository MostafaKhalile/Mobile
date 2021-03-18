import 'package:flutter/material.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';

import 'localWidgets/categories_body.dart';

class ClientCategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: CategoriesBody(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        AppLocalizations.of(context).translate('categories'),
        style: TextStyle(color: Colors.black),
      ),
      automaticallyImplyLeading: false,
      // leading: Container(),
      excludeHeaderSemantics: true,
    );
  }
}
