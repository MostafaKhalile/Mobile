import 'package:flutter/material.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';

import 'components/categories_body.dart';

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
        style:
            Theme.of(context).textTheme.headline6.copyWith(color: Colors.black),
      ),
      automaticallyImplyLeading: false,
      // leading: Container(),
      excludeHeaderSemantics: true,
    );
  }
}
