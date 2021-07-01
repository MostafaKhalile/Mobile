import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:techtime/Helpers/APIUrls.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Models/client/company.dart';
import 'package:techtime/screens/Client/companyProfile/company_profile.dart';
import 'package:techtime/widgets/client/custom_circle_avatar.dart';

class LeastCompanyCard extends StatelessWidget {
  final Company company;

  const LeastCompanyCard({Key key, this.company}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () => Navigator.pushNamed(context, CompanyProfile.routeName,
          arguments: company),
      child: Container(
        width: size.width * 0.85,
        height: size.height * 0.35,
        margin: EdgeInsets.symmetric(horizontal: KdefaultPadding / 4),
        decoration: BoxDecoration(
            image: buildCompanyCover(),
            borderRadius: BorderRadius.all(
              Radius.circular(KdefaultRadius),
            ),
            boxShadow: [
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
                borderRadius: BorderRadius.all(
                  Radius.circular(KdefaultRadius),
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  height: 110,
                  width: size.width * 0.85,
                  padding:
                      EdgeInsets.symmetric(horizontal: KdefaultPadding / 4),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: _theme.accentColor, width: 0.2),
                      borderRadius:
                          BorderRadius.all(Radius.circular(KdefaultRadius))),
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
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            company != null
                                ? Text(
                                    company.categoryEn,
                                    style: _theme.textTheme.caption
                                        .copyWith(color: Colors.black),
                                  )
                                : Container(),
                            company != null
                                ? Text(
                                    company.totalServices.toString() +
                                        " " +
                                        "Service",
                                    style: _theme.textTheme.caption
                                        .copyWith(color: Colors.black),
                                  )
                                : Container()
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
              "${KAPIURL + company?.coverImage}",
            )
          : AssetImage(KPlaceHolderCover),
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
        : CustomCircleAvatar(
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

  RatingBarIndicator buildSmoothStarRating() {
    return RatingBarIndicator(
      rating: 5.00,
      itemBuilder: (context, index) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      itemCount: 5,
      itemSize: 14.0,
                                  direction: Axis.horizontal,
    );
  }
}
