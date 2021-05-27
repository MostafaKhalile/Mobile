import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:techtime/Controllers/blocs/client/companyProfileBloc/company_profile_bloc.dart';
import 'package:techtime/Helpers/APIUrls.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/colors.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/models/client/company.dart';
import 'package:techtime/screens/Client/companyProfile/subViews/company_branches.dart';
import 'package:techtime/widgets/client/custom_circle_avatar.dart';
import 'package:techtime/widgets/core/gallery_view.dart';
import 'package:techtime/widgets/core/horizontal_gap.dart';
import 'package:techtime/widgets/core/vertical_gab.dart';

import 'subViews/company_offers.dart';
import 'subViews/company_reviews.dart';
import 'subViews/company_services.dart';

class CompanyProfile extends StatefulWidget {
  static const String routeName = "/branch_profile";
  final Company company;

  const CompanyProfile({Key key, this.company}) : super(key: key);

  @override
  _CompanyProfileState createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile>
    with SingleTickerProviderStateMixin {
  List<String> imgList = [];
  TabController _controller;
  @override
  void initState() {
    _controller = TabController(length: 4, vsync: this);
    BlocProvider.of<CompanyProfileBloc>(context)
        .add(GetCompanyProfile(widget.company.companyId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations _translator = AppLocalizations.of(context);
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(children: <Widget>[
      SafeArea(
        child: Expanded(
          flex: 3,
          child: SizedBox(
              width: _size.width,
              child: Column(
                children: <Widget>[
                  //Image Carousle for Branch View Start
                  BlocListener<CompanyProfileBloc, CompanyProfileState>(
                    listener: (context, state) {
                      if (state is CompanyProfileFinished &&
                          state.companyProfile.companyBranches.length > 0) {
                        setState(() {
                          imgList = [
                            state.companyProfile.companyData.companyCoverImage
                          ];
                        });
                      }
                    },
                    child: CarouselSlider(
                      options: CarouselOptions(
                          autoPlay: true,
                          aspectRatio: 1.9,
                          enlargeCenterPage: true,
                          pauseAutoPlayOnTouch: true),
                      items: imgList
                          .map((item) => InkWell(
                              onTap: () => Navigator.pushNamed(
                                      context, GalleryView.routeName,
                                      arguments: {
                                        'imgList': imgList,
                                        'companyName':
                                            widget.company.companyName
                                      }),
                              child: Image.network(KAPIURL + item)))
                          .toList(),
                    ),
                  ),

                  //Image Carousle for Branch View End
                  //Branch logo, name and Rating Start.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Spacer(),
                      Hero(
                          tag: widget.company.companyName,
                          child: CustomCircleAvatar(
                            height: 80,
                            width: 80,
                            image: widget.company.logo,
                          )),
                      HorizontalGap(
                        width: KdefaultPadding / 4,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: _size.width * 0.6,
                            child: Text(
                              widget.company.companyName,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      wordSpacing: 3.5),
                            ),
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
                              icon: Icon(Icons.share_outlined),
                              onPressed: () {})
                        ],
                      ),
                      Spacer()
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
                        text: _translator.translate("branches"),
                      ),
                      Tab(
                        text: _translator.translate("reviews"),
                      ),
                    ],
                  )
                ],
              )),
        ),
      ),
      Expanded(
          flex: 3,
          child: Container(
            width: double.infinity,
            child: BlocBuilder<CompanyProfileBloc, CompanyProfileState>(
              builder: (context, state) => TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: _controller,
                children: <Widget>[
                  CompanyServices(
                    companyBranches: (state is CompanyProfileFinished)
                        ? state.companyProfile.companyBranches
                        : [],
                  ),
                  CompanyOffers(),
                  CompanyBranchesScreen(
                    companyBranches: (state is CompanyProfileFinished)
                        ? state.companyProfile.companyBranches
                        : [],
                  ),
                  CompanyReviews(),
                ],
              ),
            ),
          ))
    ]));
  }
}
