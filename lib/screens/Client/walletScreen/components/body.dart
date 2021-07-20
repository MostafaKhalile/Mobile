import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:techtime/Controllers/BLoCs/client/wallet_blocs/wallet_total_data_bloc/wallet_bloc.dart';
import 'package:techtime/Controllers/providers/current_user_provider.dart';

import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/app_colors.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Models/client_profile.dart';
import 'package:techtime/Widgets/core/horizontal_gap.dart';
import 'package:techtime/Widgets/core/shimmer_effect.dart';
import '../subScreens/recharge_wallet.dart';
import '../subScreens/redeeme_points.dart';

class WalletBody extends StatefulWidget {
  const WalletBody({
    Key key,
  }) : super(key: key);

  @override
  _WalletBodyState createState() => _WalletBodyState();
}

class _WalletBodyState extends State<WalletBody> {
  UserProfile currentUser;

  PageController pageController = PageController();
  int selectedPageIndex = 0;
  @override
  void initState() {
    final _walletBloc = BlocProvider.of<WalletBloc>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      currentUser =
          Provider.of<CurrentUserProvider>(context, listen: false).currentUser;
      if (currentUser != null) _walletBloc.add(GetWalletTotalDate());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final AppLocalizations _translator = AppLocalizations.of(context);
    final ThemeData _theme = Theme.of(context);

    return Column(children: [
      SizedBox(
        width: _size.width,
        height: _size.height * 0.45,
        child: Column(
          children: [
            if (currentUser != null)
              BlocConsumer<WalletBloc, WalletState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is WalletTotalDataSucceded) {
                    return PointsCount(
                      points: state.walletTotal.points.toString(),
                    );
                  }
                  return const ShimmerEffect(
                    child: PointsCount(),
                  );
                },
              )
            else
              PointsCount(
                points: 0.0.toString(),
              ),
            if (currentUser != null)
              BlocConsumer<WalletBloc, WalletState>(
                listener: (context, state) {
                  if (state is WalletTotalDataFailed) {
                    print(state.message);
                  }
                },
                builder: (context, state) {
                  if (state is WalletTotalDataSucceded) {
                    return MoneyCount(
                      money: state.walletTotal.money.toString(),
                    );
                  }
                  return const ShimmerEffect(child: MoneyCount());
                },
              )
            else
              MoneyCount(
                money: 0.0.toString(),
              ),
            const Spacer(),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PageSelectionCard(
                    isSelected: selectedPageIndex == 0,
                    icon: rechargeWalletIcon,
                    title: _translator.translate("recharge_wallet"),
                    onTap: () => onAddButtonTapped(0),
                  ),
                  const HorizontalGap(),
                  PageSelectionCard(
                      icon: coinsIcon,
                      isSelected: selectedPageIndex == 1,
                      title: _translator.translate("redeem_your_points"),
                      onTap: () => onAddButtonTapped(1)),
                ],
              ),
            ),
            const Spacer()
          ],
        ),
      ),
      Card(
          elevation: 15,
          color: _theme.scaffoldBackgroundColor,
          shape: const RoundedRectangleBorder(
              side: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(defaultRadius),
                  topLeft: Radius.circular(defaultRadius))),
          child: SizedBox(
            height: _size.height * 0.4,
            width: _size.width,
            child: buildPageView(),
          )),
    ]);
  }

  void pageChanged(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  void onAddButtonTapped(int index) {
    // use this to animate to the page
    pageController.animateToPage(index,
        duration: const Duration(seconds: 5), curve: Curves.ease);

    // or this to jump to it without animating
    pageController.jumpToPage(index);
  }

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        RechargeWallet(onAddButtonTapped: onAddButtonTapped),
        RedeemPoints(
          onAddButtonTapped: onAddButtonTapped,
        ),
      ],
    );
  }
}

class PageSelectionCard extends StatelessWidget {
  const PageSelectionCard({
    Key key,
    this.onTap,
    this.icon,
    this.title,
    this.isSelected,
  }) : super(key: key);
  final VoidCallback onTap;
  final String icon;
  final String title;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 5,
        color: _theme.scaffoldBackgroundColor,
        shape: isSelected ?? false
            ? RoundedRectangleBorder(
                side: const BorderSide(color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(defaultRadius))
            : const RoundedRectangleBorder(
                side: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(
                  Radius.circular(defaultRadius),
                )),
        child: SizedBox(
          height: 110,
          width: 110,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                icon,
                height: 30,
                color: _theme.accentColor,
              ),
              const SizedBox(
                height: defaultPadding / 2,
              ),
              SizedBox(
                width: 80,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: _theme.textTheme.caption,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MoneyCount extends StatelessWidget {
  const MoneyCount({
    Key key,
    this.money,
  }) : super(key: key);
  final String money;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context).translate("EGP"),
              style: Theme.of(context).textTheme.caption.copyWith(
                  fontWeight: FontWeight.bold, color: AppColors.darkGreyColor),
            ),
            SizedBox(
              width: 80,
              child: Text(
                "${money ?? 0}",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            Text(
              AppLocalizations.of(context).translate("available_credit"),
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                  fontWeight: FontWeight.bold, color: AppColors.darkGreyColor),
            ),
          ],
        )
      ],
    );
  }
}

class PointsCount extends StatelessWidget {
  const PointsCount({
    Key key,
    this.points,
  }) : super(key: key);
  final String points;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              text: "${points ?? 0} \t\t",
              style: Theme.of(context).textTheme.subtitle2,
              children: <TextSpan>[
                TextSpan(
                  text: AppLocalizations.of(context).translate("point"),
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                      color: AppColors.darkGreyColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
