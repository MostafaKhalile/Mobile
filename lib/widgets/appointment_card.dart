import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/colors.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/screens/Client/saloonProfile/saloonProfile.dart';

import 'core/horizontal_gap.dart';
import 'core/vertical_gab.dart';

class AppointmentCard extends StatelessWidget {
  final String title;
  final String description;
  final String address;
  final String image;
  final double rating;
  final Function onPressed;
  final bool isReadOnly;

  const AppointmentCard({
    Key key,
    @required ThemeData theme,
    @required AppLocalizations translator,
    this.title,
    this.description,
    this.address,
    this.image,
    this.rating,
    this.onPressed,
    @required this.isReadOnly,
  })  : _theme = theme,
        _translator = translator,
        super(key: key);

  final ThemeData _theme;
  final AppLocalizations _translator;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        height: 195,
        child: Container(
          child: Column(
            children: [
              Container(
                height: 56,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(KdefaultRadius),
                        topLeft: Radius.circular(KdefaultRadius)),
                    color: KDarkGreyColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("تصفيف شعر"),
                    Text("الإثنين 12/4/2021"),
                    Text("500 ريال"),
                  ],
                ),
              ),
              Container(
                height: 139,
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill, image: AssetImage(image)),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(KdefaultRadius),
                                  bottomRight:
                                      Radius.circular(KdefaultRadius))),
                        )),
                    Expanded(
                        flex: 6,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: KDefaultPadding / 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                  SvgPicture.asset(
                                    KCoinsIcon,
                                    height: 20,
                                  ),
                                  HorizontalGap(
                                    width: 5.0,
                                  ),
                                  Container(
                                    child: Text(
                                      address,
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
                                    color: Colors.yellowAccent,
                                  ),
                                  HorizontalGap(
                                    width: 5.0,
                                  ),
                                  Text(rating.toString()),
                                  Spacer(),
                                  isReadOnly
                                      ? Container()
                                      : RaisedButton(
                                          textColor: Colors.white,
                                          color: KSecondryColor,
                                          child: Text(
                                              _translator.translate("book")),
                                          onPressed: () => Navigator.pushNamed(
                                              context, SalonProfile.routeName),
                                          shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(
                                                    KdefaultRadius),
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
            ],
          ),
        ),
      ),
    );
  }
}
