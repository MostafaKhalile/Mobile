import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/network_constants.dart';
import 'package:techtime/Models/client/company.dart';
import 'package:techtime/screens/Client/companyProfile/company_profile.dart';
import 'package:techtime/widgets/client/custom_circle_avatar.dart';

class LeastCompanyCard extends StatelessWidget {
  final Company company;

  const LeastCompanyCard({Key key, this.company}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () => Navigator.pushNamed(context, CompanyProfile.routeName,
          arguments: company),
      child: Container(
        width: size.width * 0.85,
        height: size.height * 0.35,
        margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 4),
        decoration: BoxDecoration(
            image: buildCompanyCover(),
            borderRadius: const BorderRadius.all(
              Radius.circular(defaultRadius),
            ),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Colors.black38,
                offset: Offset(0, 5),
                blurRadius: 10.0,
              )
            ]),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2.0),
                borderRadius: const BorderRadius.all(
                  Radius.circular(defaultRadius),
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  height: 110,
                  width: size.width * 0.85,
                  padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding / 4),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: _theme.accentColor, width: 0.2),
                      borderRadius: const BorderRadius.all(
                          Radius.circular(defaultRadius))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Hero(
                          tag: company?.companyName ?? "",
                          child: buildCompanyLogo()),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            buildCompanyName(_theme),
                            buildSmoothStarRating(),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (company != null)
                              Text(
                                company.categoryEn,
                                style: _theme.textTheme.caption
                                    .copyWith(color: Colors.black),
                              )
                            else
                              Container(),
                            if (company != null)
                              Text(
                                "${company.totalServices} Service",
                                style: _theme.textTheme.caption
                                    .copyWith(color: Colors.black),
                              )
                            else
                              Container()
                          ],
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  DecorationImage buildCompanyCover() {
    return DecorationImage(
      image: company?.coverImage != null
          ? NetworkImage(
              NetworkConstants.baseUrl + company?.coverImage,
            ) as ImageProvider
          : const AssetImage(placeHolderCover),
      fit: BoxFit.fill,
    );
  }

  CustomCircleAvatar buildCompanyLogo() {
    return company != null
        ? CustomCircleAvatar(
            width: 80,
            height: 80,
            image: company.logo,
          )
        : const CustomCircleAvatar(
            image: null,
            width: 80,
            height: 80,
          );
  }

  Widget buildCompanyName(ThemeData _theme) {
    return company != null
        ? Text(
            company?.companyName,
            overflow: TextOverflow.ellipsis,
            style: _theme.textTheme.subtitle2.copyWith(color: Colors.black),
          )
        : Container();
  }

  SmoothStarRating buildSmoothStarRating() {
    return SmoothStarRating(
      isReadOnly: true,
      size: 14,
      allowHalfRating: false,
      spacing: 2.0,
    );
  }
}
