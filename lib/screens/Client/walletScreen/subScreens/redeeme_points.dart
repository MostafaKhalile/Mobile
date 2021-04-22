import 'package:flutter/material.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import '../components/wallet_input.dart';
import 'package:techtime/widgets/core/vertical_gab.dart';

class RedeemPoints extends StatelessWidget {
  final void Function(int) onAddButtonTapped;

  const RedeemPoints({Key key, this.onAddButtonTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations _translator = AppLocalizations.of(context);
    ThemeData _theme = Theme.of(context);
    return Padding(
        padding: const EdgeInsets.only(top: KdefaultPadding),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Text(
                _translator.translate("redeem_your_points"),
                style: _theme.textTheme.headline5,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Text(
                _translator.translate("enter_the_number_of_points_to_transfer"),
                style: _theme.textTheme.subtitle1,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  _translator.translate("point"),
                  style: _theme.textTheme.caption
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                WalletInputField(
                  theme: _theme,
                  hintText: "0",
                ),
                Text(_translator.translate("available_credit"),
                    style: _theme.textTheme.caption
                        .copyWith(fontWeight: FontWeight.bold)),
                VerticalGap(),
                RaisedButton(
                  onPressed: () {},
                  child: Text(
                    _translator.translate("confirm"),
                    style: _theme.textTheme.button,
                  ),
                )
              ],
            )
          ],
        ));
  }
}
