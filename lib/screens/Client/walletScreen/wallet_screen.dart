import 'package:flutter/material.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/widgets/core/horizontal_gap.dart';

class WalletScreen extends StatefulWidget {
  static const String routeName = "/my_wallet";
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    ThemeData _theme = Theme.of(context);
    return Scaffold(
      body: SizedBox(
          width: _size.width,
          height: _size.height,
          child: Stack(children: [
            Container(
              width: _size.width,
              height: _size.height * 0.6,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(KdefaultRadius),
                      )),
                      child: Container(
                        height: 130,
                        width: 130,
                      ),
                    ),
                    HorizontalGap(),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(KdefaultRadius),
                      )),
                      child: Container(
                        height: 130,
                        width: 130,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Card(
                elevation: 15,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(KdefaultRadius),
                        topRight: Radius.circular(KdefaultRadius))),
                child: Container(
                    height: _size.height * 0.6,
                    width: _size.width,
                    child: Center(
                      child: Text(
                          "Animated Scrollable page for Wallet & PromoCode's"),
                    )),
              ),
            )
          ])),
    );
  }
}
