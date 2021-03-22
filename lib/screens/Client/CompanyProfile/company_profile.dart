import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:techtime/Helpers/APIUrls.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/colors.dart';
import 'package:techtime/widgets/core/vertical_gab.dart';

class CompanyProfile extends StatelessWidget {
  final int id;
  static const String routeName = "/company_profile";

  const CompanyProfile({Key key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      width: double.infinity,
      child: Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: NetworkImage(
                      KPlaceHolder,
                    ),
                    fit: BoxFit.fill,
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: KdefaultPadding, vertical: KdefaultPadding / 2),
                child: Row(
                  children: [
                    SmoothStarRating(
                      size: 18,
                    ),
                    Spacer(),
                    Icon(
                      Icons.share_outlined,
                      size: 35,
                      color: KPrimaryColor,
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[],
                    ),
                  ),
                ),
              )
            ],
          ),
          Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: KdefaultPadding / 4),
                padding: EdgeInsets.all(2),
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: KPrimaryColor, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).shadowColor.withOpacity(0.1),
                        spreadRadius: 4,
                        blurRadius: 4,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius:
                        BorderRadius.all(Radius.circular(KdefaultRadius)),
                    image: DecorationImage(
                        image: NetworkImage(KPlaceHolder),
                        repeat: ImageRepeat.noRepeat,
                        // alignment: Alignment.center,
                        fit: BoxFit.fill)),
              ),
              VerticalGap(),
              Text(
                "Prestige car wash",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    wordSpacing: 3.5),
              )
            ],
          ))
        ],
      ),
    );
  }
}
