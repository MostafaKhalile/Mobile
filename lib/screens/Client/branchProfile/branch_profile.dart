import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/colors.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/widgets/client/custom_circle_avatar.dart';
import 'package:techtime/widgets/core/gallery_view.dart';
import 'package:techtime/widgets/core/horizontal_gap.dart';
import 'package:techtime/widgets/core/vertical_gab.dart';

import 'subViews/branch_info.dart';
import 'subViews/branch_offers.dart';
import 'subViews/branch_reviews.dart';
import 'subViews/branch_services.dart';

class BranchProfile extends StatefulWidget {
  static const String routeName = "/branch_profile";

  @override
  _BranchProfileState createState() => _BranchProfileState();
}

class _BranchProfileState extends State<BranchProfile>
    with SingleTickerProviderStateMixin {
  final List imgList = [
    KPlaceHolderCover,
    KPlaceHolderCover,
    KPlaceHolderCover,
    KPlaceHolderCover,
    KPlaceHolderCover
  ];
  TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations _translator = AppLocalizations.of(context);
    return Scaffold(
        body: Column(children: <Widget>[
      Expanded(
        flex: 3,
        child: SizedBox(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                //Image Carousle for Branch View Start
                CarouselSlider(
                  options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 1.9,
                      enlargeCenterPage: true,
                      pauseAutoPlayOnTouch: true),
                  items: imgList
                      .map((item) => InkWell(
                          onTap: () => Navigator.pushNamed(
                              context, GalleryView.routeName),
                          child: Image.asset(item)))
                      .toList(),
                ),

                //Image Carousle for Branch View End
                //Branch logo, name and Rating Start.
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomCircleAvatar(
                      height: 100,
                      width: 100,
                      image: null,
                    ),
                    HorizontalGap(
                      width: KdefaultPadding / 4,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "companyName",
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              wordSpacing: 3.5),
                        ),
                        VerticalGap(
                          height: KdefaultPadding / 2,
                        ),
                        SmoothStarRating(
                          isReadOnly: true,
                          rating: 5.0,
                          size: 14,
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            icon: Icon(Icons.favorite_border),
                            onPressed: () {}),
                        IconButton(
                            icon: Icon(Icons.share_outlined), onPressed: () {})
                      ],
                    )
                  ],
                ),
                VerticalGap(),
                //Branch logo, name and Rating End.
                TabBar(
                  controller: _controller,
                  indicatorColor: KPrimaryColor,
                  isScrollable: false,
                  tabs: [
                    Tab(
                      text: _translator.translate("services"),
                    ),
                    Tab(
                      text: _translator.translate("offers"),
                    ),
                    Tab(
                      text: _translator.translate("info"),
                    ),
                    Tab(
                      text: _translator.translate("reviews"),
                    ),
                  ],
                )
              ],
            )),
      ),
      Expanded(
        flex: 3,
        child: Container(
          width: double.infinity,
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: _controller,
            children: <Widget>[
              BranchServices(),
              BranchOffers(),
              BranchInfo(),
              BranchReviews(),
            ],
          ),
        ),
      )
    ]));
  }
}
