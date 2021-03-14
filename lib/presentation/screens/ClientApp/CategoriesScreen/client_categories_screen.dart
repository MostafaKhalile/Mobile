import 'package:flutter/material.dart';
import 'package:techtime/data/models/AppConfgModels/app_localizations_delegates.dart';

class ClientCategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate('categories'),
          style: TextStyle(color: Colors.black),
        ),
        leading: Container(),
        excludeHeaderSemantics: true,
      ),
    );
  }
}
