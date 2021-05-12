import 'package:flutter/material.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';

import 'components/categories_body.dart';

class ClientCategoriesScreen extends StatelessWidget {
  static const String routeName = "/categoriesPage";
  final bool isCloseable;
  const ClientCategoriesScreen({Key key, this.isCloseable}) : super(key: key);
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
      iconTheme: IconThemeData(color: Colors.black),
      automaticallyImplyLeading: isCloseable,
      excludeHeaderSemantics: true,
    );
  }
}
