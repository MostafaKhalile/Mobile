import 'package:flutter/material.dart';
import 'package:techtime/constants/app_consts.dart';
import 'package:techtime/data/models/AppConfgModels/app_localizations_delegates.dart';
import 'package:techtime/data/models/company.dart';

import 'custom_circle_avatar.dart';

class CompanyCard extends StatelessWidget {
  final Company company;

  const CompanyCard({Key key, this.company}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData _theme = Theme.of(context);
    return Container(
      width: size.width * 0.7,
      margin: EdgeInsets.symmetric(horizontal: KdefaultPadding / 4),
      decoration: BoxDecoration(
          color: _theme.scaffoldBackgroundColor,
          border: Border.all(color: _theme.accentColor, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(KdefaultRadius)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 5),
              blurRadius: 10.0,
            )
          ]),
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(KAPIURL + company.coverImage),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(KdefaultRadius),
                        topRight: Radius.circular(KdefaultRadius)),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.symmetric(horizontal: KDefaultPadding),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: size.width * 0.4,
                          child: RichText(
                              overflow: TextOverflow.clip,
                              textScaleFactor: 0.9,
                              text: TextSpan(
                                text: '${company.companyName} \n',
                                style: _theme.textTheme.caption
                                    .copyWith(height: 1.12),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '${company.categoryRegionEn} ',
                                      style: _theme.textTheme.caption),
                                  TextSpan(
                                      text: ' ${company.categoryCityEn}, '
                                          '${AppLocalizations.of(context).translate('Egypt')}.',
                                      style: _theme.textTheme.caption),
                                ],
                              )),
                        ),
                      ]),
                ),
              )
            ],
          ),
          Positioned(
              top: 10,
              right: 10,
              left: 10,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 25,
                    color: KPrimaryColor,
                  ),
                ],
              )),
          Positioned(
            bottom: size.width * 0.16,
            right: 10,
            left: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: CustomCircleAvatar(image: KAPIURL + company.logo),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
