import 'package:flutter/material.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';

import 'components/body.dart';

class WalletScreen extends StatefulWidget {
  static const String routeName = "/my_wallet";
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final AppLocalizations _translator = AppLocalizations.of(context);
    // ThemeData _theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        automaticallyImplyLeading: false,
        title: Text(
          _translator.translate("myWallet"),
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.black),
        ),
      ),
      body: SizedBox(
          width: _size.width,
          height: _size.height,
          child: const SingleChildScrollView(
            child: WalletBody(),
          )),
    );
  }
}
