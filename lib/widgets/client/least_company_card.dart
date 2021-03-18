import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:techtime/Helpers/APIUrls.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/models/client/company.dart';
import 'package:techtime/widgets/client/custom_circle_avatar.dart';

class LeastCompanyCard extends StatelessWidget {
  final Company company;

  const LeastCompanyCard({Key key, this.company}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    return Container(
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
                padding: EdgeInsets.symmetric(horizontal: KdefaultPadding / 4),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: _theme.accentColor, width: 0.2),
                    borderRadius:
                        BorderRadius.all(Radius.circular(KdefaultRadius))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildCompanyLogo(),
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
                          Text(
                            company.categoryEn,
                            style: _theme.textTheme.caption
                                .copyWith(color: Colors.black),
                          ),
                          Text(
                            company.totalServices.toString() + " " + "Service",
                            style: _theme.textTheme.caption
                                .copyWith(color: Colors.black),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }

  DecorationImage buildCompanyCover() {
    return DecorationImage(
      image: NetworkImage(
        KAPIURL + company.coverImage,
      ),
      fit: BoxFit.fill,
    );
  }

  CustomCircleAvatar buildCompanyLogo() {
    return CustomCircleAvatar(
      width: 80,
      height: 80,
      image: KAPIURL + company.logo,
    );
  }

  Text buildCompanyName(ThemeData _theme) {
    return Text(
      company.companyName,
      overflow: TextOverflow.ellipsis,
      style: _theme.textTheme.subtitle2.copyWith(color: Colors.black),
    );
  }

  SmoothStarRating buildSmoothStarRating() {
    return SmoothStarRating(
      rating: company.raty,
      isReadOnly: true,
      size: 14,
      filledIconData: Icons.star,
      halfFilledIconData: Icons.star_half,
      defaultIconData: Icons.star_border,
      starCount: 5,
      allowHalfRating: false,
      spacing: 2.0,
    );
  }
}
