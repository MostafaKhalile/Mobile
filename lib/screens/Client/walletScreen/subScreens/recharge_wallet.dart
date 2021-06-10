import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techtime/Controllers/BLoCs/client/wallet_blocs/wallet_transform_promocode_bloc/wallettransformpromocode_bloc.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Helpers/utils/custom_toast.dart';
import 'package:techtime/widgets/core/vertical_gab.dart';
import '../components/wallet_input.dart';

class RechargeWallet extends StatefulWidget {
  final void Function(int) onAddButtonTapped;

  const RechargeWallet({Key key, this.onAddButtonTapped}) : super(key: key);

  @override
  _RechargeWalletState createState() => _RechargeWalletState();
}

class _RechargeWalletState extends State<RechargeWallet> {
  TextEditingController _promoCodeController = TextEditingController();
  CustomToast _customToast = CustomToast();
  @override
  void initState() {
    BlocProvider.of<WallettransformpromocodeBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations _translator = AppLocalizations.of(context);
    ThemeData _theme = Theme.of(context);

    return BlocConsumer<WallettransformpromocodeBloc,
        WallettransformpromocodeState>(
      listener: (context, state) {
        if (state is WallettransformpromocodeFailed) {
          _customToast.buildErrorMessage(context, state.message);
        }
      },
      builder: (context, state) {
        final walletState = state;
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
                      controller: _promoCodeController,
                      keyboardType: TextInputType.text,
                      theme: _theme,
                      hintText: "_",
                    ),
                    VerticalGap(),
                    // ignore: deprecated_member_use
                    RaisedButton(
                      onPressed: (walletState
                              is WallettransformpromocodeLoading)
                          ? null
                          : () => BlocProvider.of<WallettransformpromocodeBloc>(
                                  context)
                              .add(WalletTranseferePromocode(
                                  _promoCodeController.text)),
                      child: (walletState is WallettransformpromocodeLoading)
                          ? SizedBox(
                              width: 10,
                              height: 10,
                              child: CircularProgressIndicator(),
                            )
                          : Text(
                              _translator.translate("confirm"),
                              style: _theme.textTheme.button,
                            ),
                    )
                  ],
                )
              ],
            ));
      },
    );
  }
}
