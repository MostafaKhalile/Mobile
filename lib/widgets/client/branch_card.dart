import 'package:flutter/material.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/colors.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/screens/Client/saloonProfile/saloonProfile.dart';
import 'package:techtime/widgets/core/horizontal_gap.dart';
import 'package:techtime/widgets/core/vertical_gab.dart';

class BranchCard extends StatelessWidget {
  final String title;
  final String description;
  final String address;
  final String image;
  final double rating;
  final Function onPressed;

  const BranchCard({
    Key key,
    this.title,
    this.description,
    this.address,
    this.image,
    this.rating,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    AppLocalizations _translator = AppLocalizations.of(context);
    return Card(
      margin: EdgeInsets.only(bottom: KDefaultPadding),
      child: Container(
        height: 150,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(boxShadow: [
          // BoxShadow(
          //     color: KDarkGreyColor, blurRadius: 20, offset: Offset(10, 10))
        ], borderRadius: BorderRadius.circular(KDefaultPadding)),
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill, image: AssetImage(image)),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      )),
                )),
            Expanded(
                flex: 6,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: KDefaultPadding / 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: _theme.textTheme.subtitle1,
                      ),
                      Text(
                        description,
                        style: _theme.textTheme.caption,
                      ),
                      Row(
                        children: [
                          Container(
                            child: Text(
                              address,
                              style: _theme.textTheme.subtitle1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                      VerticalGap(
                        height: KDefaultPadding / 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.star_purple500_sharp,
                            color: KPrimaryColor,
                          ),
                          HorizontalGap(
                            width: 5.0,
                          ),
                          Text(
                            rating.toString(),
                            style: _theme.textTheme.caption,
                          ),
                          Spacer(),
                          // ignore: deprecated_member_use
                          RaisedButton(
                            color: KSecondryColor,
                            child: Text(_translator.translate("book_now")),
                            onPressed: () => Navigator.pushNamed(
                                context, SalonProfile.routeName),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
