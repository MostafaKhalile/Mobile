import 'package:flutter/material.dart';

import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/app_colors.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Helpers/network_constants.dart';
import 'package:techtime/Models/client/company.dart';
import 'package:techtime/screens/Client/companyProfile/company_profile.dart';

import 'custom_circle_avatar.dart';

class CompanyCard extends StatelessWidget {
  final Company? company;

  const CompanyCard({Key? key, this.company}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData _theme = Theme.of(context);
    return InkWell(
        onTap: () => Navigator.pushNamed(context, CompanyProfile.routeName,
            arguments: company),
        child: Container(
          width: size.width * 0.6,
          margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 4),
          decoration: BoxDecoration(
              color: _theme.scaffoldBackgroundColor,
              border: Border.all(color: _theme.accentColor, width: 2.0),
              borderRadius:
                  const BorderRadius.all(Radius.circular(defaultRadius)),
              boxShadow: const <BoxShadow>[
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
                          image: company?.coverImage != null
                              ? NetworkImage(NetworkConstants.baseUrl +
                                  company!.coverImage!) as ImageProvider
                              : const AssetImage(placeHolderCover),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(defaultRadius),
                            topRight: Radius.circular(defaultRadius)),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (company != null)
                              SizedBox(
                                width: size.width * 0.4,
                                child: RichText(
                                    textScaleFactor: 0.9,
                                    text: TextSpan(
                                      text: '${company!.companyName} \n',
                                      style: _theme.textTheme.caption!
                                          .copyWith(height: 1.12),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:
                                                '${company!.categoryRegionEn} ',
                                            style: _theme.textTheme.caption),
                                        TextSpan(
                                            text: ' ${company!.categoryCityEn}, '
                                                '${AppLocalizations.of(context)!.translate('Egypt')}.',
                                            style: _theme.textTheme.caption),
                                      ],
                                    )),
                              )
                            else
                              Container(),
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const <Widget>[
                      Icon(
                        Icons.favorite_border,
                        size: 25,
                        color: AppColors.primaryColor,
                      ),
                    ],
                  )),
              Positioned(
                bottom: size.width * 0.12,
                right: 10,
                left: 10,
                child: Row(
                  children: [
                    Hero(
                      tag: company?.companyName ?? UniqueKey(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: company != null
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomCircleAvatar(
                                  image: company!.logo,
                                  width: 70,
                                  height: 70,
                                ),
                              )
                            : const CustomCircleAvatar(
                                image: null,
                                width: 70,
                                height: 70,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
