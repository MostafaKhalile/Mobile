import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtime/presentation/screens/SharedViews/search_screen.dart';

import 'CategoriesScreen/client_categories_screen.dart';
import 'HomeScreen/client_home_screen.dart';
import 'OffresScreen/client_offers_screen.dart';

class ClientHomePage extends StatefulWidget {
  @override
  _ClientHomePageState createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    var appTheme = Theme.of(context);
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 60.0,
          items: <Widget>[
            Padding(
                padding: EdgeInsets.all(5),
                child: SvgPicture.asset(
                  "assets/svg/home.svg",
                  height: 20,
                  color: appTheme.primaryColorDark,
                )),
            Padding(
                padding: EdgeInsets.all(5),
                child: SvgPicture.asset(
                  "assets/svg/categories.svg",
                  height: 20,
                  color: appTheme.primaryColorDark,
                )),
            Padding(
              padding: EdgeInsets.all(5),
              child: SvgPicture.asset(
                "assets/svg/offers.svg",
                height: 20,
                color: appTheme.primaryColorDark,
              ),
            ),
            Padding(
                padding: EdgeInsets.all(5),
                child: SvgPicture.asset(
                  "assets/svg/account.svg",
                  height: 20,
                  color: appTheme.primaryColorDark,
                )),
            Padding(
                padding: EdgeInsets.all(5),
                child: SvgPicture.asset(
                  "assets/svg/schedule.svg",
                  height: 20,
                  color: appTheme.primaryColorDark,
                )),
          ],
          // color: Colors.white,
          buttonBackgroundColor: appTheme.primaryColor,
          backgroundColor: appTheme.scaffoldBackgroundColor,
          color: appTheme.bottomAppBarColor,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {});
            _pageController.jumpToPage(index);
          },
          letIndexChange: (index) => true,
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _page = index;
            });
            CurvedNavigationBarState navBarState =
                _bottomNavigationKey.currentState;
            navBarState.setPage(_page);
          },
          children: [
            ClientHomeScreen(),
            ClientCategoriesScreen(),
            ClientOffersScreen(),
            SearchScreen(),
            ClientHomeScreen(),
          ],
        ));
  }
}
//  Container(
//         color: Theme.of(context).scaffoldBackgroundColor,
//         child: Center(
//           child: Column(
//             children: <Widget>[
//               Text(_page.toString(), textScaleFactor: 10.0),
//               RaisedButton(
//                 child: Text('Go To Page of index 1'),
//                 onPressed: () {
//                   final CurvedNavigationBarState navBarState =
//                       _bottomNavigationKey.currentState;
//                   navBarState.setPage(1);
//                 },
//               )
//             ],
//           ),
//         ),
//       )
