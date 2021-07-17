import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';
import 'package:techtime/Controllers/BLoCs/client/wallet_blocs/wallet_points_to_price_bloc/walletpointstoprice_bloc.dart';
import 'package:techtime/Controllers/BLoCs/client/wallet_blocs/wallet_transform_points_blob/wallettransformpoints_bloc.dart';
import 'package:techtime/Controllers/providers/current_user_provider.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Helpers/utils/custom_toast.dart';
import 'package:techtime/Widgets/core/horizontal_gap.dart';
import 'package:techtime/Widgets/core/vertical_gab.dart';
import '../components/wallet_input.dart';

class RedeemPoints extends StatefulWidget {
  final void Function(int) onAddButtonTapped;

  const RedeemPoints({Key key, this.onAddButtonTapped}) : super(key: key);

  @override
  _RedeemPointsState createState() => _RedeemPointsState();
}

class _RedeemPointsState extends State<RedeemPoints> {
  final TextEditingController _pointsController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<WalletpointstopriceBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations _translator = AppLocalizations.of(context);
    final ThemeData _theme = Theme.of(context);
    final CustomToast _customToast = CustomToast();
    final _currentUser = context.watch<CurrentUserProvider>().currentUser;

    return BlocConsumer<WalletpointstopriceBloc, WalletpointstopriceState>(
      listener: (context, state) {
        if (state is WalletPointsToPriceSucceded) {
          _redeemValue(_theme, state.walletTotal.money);
        }
        if (state is WalletPointsToPriceFailed) {
          _customToast.buildErrorMessage(context, state.message);
        }
      },
      builder: (context, state) {
        final walletState = state;
        return Padding(
            padding: const EdgeInsets.only(top: defaultPadding),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    _translator.translate("redeem_your_points"),
                    style: _theme.textTheme.headline5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    _translator
                        .translate("enter_the_number_of_points_to_transfer"),
                    style: _theme.textTheme.subtitle1,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      _translator.translate("point"),
                      style: _theme.textTheme.caption
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    WalletInputField(
                      controller: _pointsController,
                      keyboardType: TextInputType.number,
                      theme: _theme,
                      hintText: "0",
                    ),

                    const VerticalGap(),
                    // ignore: deprecated_member_use
                    RaisedButton(
                      onPressed: (walletState is WalletPointsToPriceLoading)
                          ? null
                          : () {
                              if (_currentUser != null) {
                                BlocProvider.of<WalletpointstopriceBloc>(
                                        context)
                                    .add(GetWalletPointsToPrice(
                                        _pointsController.text));
                              } else {
                                Fluttertoast.showToast(
                                    msg: _translator
                                        .translate("please_login_first"));
                              }
                            },
                      child: (walletState is WalletPointsToPriceLoading)
                          ? const SizedBox(
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

  Future<void> _redeemValue(ThemeData _theme, double value) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return RedeemPointsDialog(
          value: value,
          points: _pointsController.text,
        );
      },
    );
  }
}

class RedeemPointsDialog extends StatefulWidget {
  const RedeemPointsDialog({
    Key key,
    this.value,
    @required this.points,
  }) : super(key: key);
  final double value;
  final String points;

  @override
  _RedeemPointsDialogState createState() => _RedeemPointsDialogState();
}

class _RedeemPointsDialogState extends State<RedeemPointsDialog> {
  final CustomToast _customToast = CustomToast();

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final AppLocalizations _translator = AppLocalizations.of(context);
    return BlocConsumer<WallettransformpointsBloc, WallettransformpointsState>(
      listener: (context, state) {
        if (state is WallettransformpointsFailed) {
          _customToast.buildErrorMessage(context, state.message);
        }
      },
      builder: (context, state) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context).translate("redeem_value")),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Shimmer.fromColors(
                    baseColor: const Color(0xFFAE8625),
                    highlightColor: const Color(0xFFF7EF8A),
                    child: SizedBox(
                        height: 60,
                        width: 60,
                        child: SvgPicture.asset(
                          coinsIcon,
                          height: 30,
                        ))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.value.toString(),
                        style: _theme.textTheme.headline3.copyWith(
                            fontWeight: FontWeight.bold,
                            color: _theme.accentColor)),
                    const HorizontalGap(),
                    Text(
                      _translator.translate("EGP"),
                      style: _theme.textTheme.caption.copyWith(
                          fontWeight: FontWeight.bold,
                          color: _theme.accentColor),
                    ),
                  ],
                ),
                Text(
                  AppLocalizations.of(context).translate("note"),
                  style: _theme.textTheme.caption
                      .copyWith(color: _theme.accentColor),
                ),
                Text(
                  _translator
                      .translate("only_you_can_redeem_multiples_of_thousand"),
                  style: _theme.textTheme.caption
                      .copyWith(color: _theme.accentColor),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            // ignore: deprecated_member_use
            FlatButton(
              onPressed: () => _checkRedeemValidity(widget.value),
              child: (state is WallettransformpointsLoading)
                  ? const SizedBox(
                      width: 10,
                      height: 10,
                      child: CircularProgressIndicator(),
                    )
                  : Text(
                      _translator.translate("confirm"),
                      style: _theme.textTheme.button,
                    ),
            ),
          ],
        );
      },
    );
  }

  void _checkRedeemValidity(value) {
    print("${value % 10}");

    if (value % 10 == 0) {
      BlocProvider.of<WallettransformpointsBloc>(context)
          .add(WalletTranseferePoints(widget.points));
    } else {
      _customToast.buildErrorMessage(
          context,
          AppLocalizations.of(context)
              .translate('only_you_can_redeem_multiples_of_thousand'));
      print("valus is not valid");
    }
  }
}
