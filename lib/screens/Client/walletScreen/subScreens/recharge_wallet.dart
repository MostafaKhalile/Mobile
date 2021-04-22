import 'package:flutter/material.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/widgets/core/vertical_gab.dart';
import '../components/wallet_input.dart';

class RechargeWallet extends StatelessWidget {
  final void Function(int) onAddButtonTapped;

  const RechargeWallet({Key key, this.onAddButtonTapped}) : super(key: key);

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
              _translator.translate("recharge_wallet"),
              style: _theme.textTheme.headline5,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Text(
              _translator.translate("Enter_the_promo_code"),
              style: _theme.textTheme.subtitle1,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _translator.translate("promocode"),
                style: _theme.textTheme.caption
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              WalletInputField(
                theme: _theme,
                hintText: "_",
              ),
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
      ),
    );
  }
}
