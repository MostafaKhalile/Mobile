import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtime/Screens/Core/ReservationsScreen/reservations_screen.dart';
import 'package:techtime/Screens/Core/prevent_close_btn.dart';

import 'Categories/client_categories_screen.dart';
import 'HomeScreen/client_home_screen.dart';
import 'profile/profile.dart';
import 'walletScreen/wallet_screen.dart';

class ClientHomePage extends StatefulWidget {
  static const String routeName = "/clientHome";
  @override
  _ClientHomePageState createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    return PreventCloseButton(
      child: Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            key: _bottomNavigationKey,
            height: 60.0,
            items: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(5),
                  child: SvgPicture.asset(
                    "assets/svg/home.svg",
                    height: 20,
                    color: appTheme.primaryColorDark,
                  )),
              Padding(
                  padding: const EdgeInsets.all(5),
                  child: SvgPicture.asset(
                    "assets/svg/categories.svg",
                    height: 20,
                    color: appTheme.primaryColorDark,
                  )),
              Padding(
                padding: const EdgeInsets.all(5),
                child: SvgPicture.asset(
                  "assets/svg/wallet.svg",
                  height: 20,
                  color: appTheme.primaryColorDark,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(5),
                  child: SvgPicture.asset(
                    "assets/svg/calendar.svg",
                    height: 20,
                    color: appTheme.primaryColorDark,
                  )),
              Padding(
                  padding: const EdgeInsets.all(5),
                  child: SvgPicture.asset(
                    "assets/svg/account.svg",
                    height: 20,
                    color: appTheme.primaryColorDark,
                  )),
            ],
            // color: Colors.white,
            buttonBackgroundColor: appTheme.primaryColor,
            backgroundColor: appTheme.scaffoldBackgroundColor,
            color: appTheme.bottomAppBarColor,
            animationCurve: Curves.easeInOut,
            // ignore: avoid_redundant_argument_values
            animationDuration: const Duration(milliseconds: 600),
            onTap: (index) {
              setState(() {});
              _pageController.jumpToPage(index);
            },
            // letIndexChange: (index) => true,
          ),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _page = index;
              });
              final CurvedNavigationBarState? navBarState =
                  _bottomNavigationKey.currentState;
              navBarState?.setPage(_page);
            },
            children: [
              ClientHomeScreen(),
              const ClientCategoriesScreen(
                isCloseable: false,
              ),
              WalletScreen(),
              ReservationsScreen(),
              ProfileScreen(),
            ],
          )),
    );
  }
}
