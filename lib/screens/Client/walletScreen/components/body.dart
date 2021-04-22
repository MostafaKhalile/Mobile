import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/colors.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import '../subScreens/recharge_wallet.dart';
import '../subScreens/redeeme_points.dart';
import 'package:techtime/widgets/core/horizontal_gap.dart';

class WalletBody extends StatefulWidget {
  WalletBody({
    Key key,
  }) : super(key: key);

  @override
  _WalletBodyState createState() => _WalletBodyState();
}

class _WalletBodyState extends State<WalletBody> {
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  int selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    AppLocalizations _translator = AppLocalizations.of(context);

    return Column(children: [
      Container(
        width: _size.width,
        height: _size.height * 0.45,
        child: Column(
          children: [
            PointsCount(),
            MoneyCount(),
            Spacer(),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PageSelectionCard(
                    isSelected: selectedPageIndex == 0,
                    icon: KRechargeWalletIcon,
                    title: _translator.translate("recharge_wallet"),
                    onTap: () => onAddButtonTapped(0),
                  ),
                  HorizontalGap(),
                  PageSelectionCard(
                      icon: KCoinsIcon,
                      isSelected: selectedPageIndex == 1,
                      title: _translator.translate("redeem_your_points"),
                      onTap: () => onAddButtonTapped(1)),
                ],
              ),
            ),
            Spacer()
          ],
        ),
      ),
      Card(
          elevation: 15,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(KdefaultRadius))),
          child: Container(
            height: _size.height * 0.6,
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
        duration: Duration(seconds: 5), curve: Curves.ease);

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
  final Function onTap;
  final String icon;
  final String title;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: isSelected ?? false
            ? RoundedRectangleBorder(
                side: BorderSide(color: KPrimaryColor, width: 1),
                borderRadius: BorderRadius.circular(KdefaultRadius))
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                Radius.circular(KdefaultRadius),
              )),
        child: Container(
          height: 110,
          width: 110,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                icon,
                height: 30,
                color: _theme.accentColor,
              ),
              SizedBox(
                height: KdefaultPadding / 2,
              ),
              Container(
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
  }) : super(key: key);

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
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(fontWeight: FontWeight.bold, color: KDarkGreyColor),
            ),
            Container(
              width: 80,
              child: Text(
                "0",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            Text(
              AppLocalizations.of(context).translate("available_credit"),
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  .copyWith(fontWeight: FontWeight.bold, color: KDarkGreyColor),
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              text: "1000 \t\t",
              style: Theme.of(context).textTheme.subtitle2,
              children: <TextSpan>[
                TextSpan(
                  text: AppLocalizations.of(context).translate("point"),
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                      color: KDarkGreyColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
