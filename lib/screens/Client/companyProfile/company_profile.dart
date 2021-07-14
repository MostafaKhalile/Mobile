import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:techtime/Controllers/BLoCs/client/companyProfileBloc/company_profile_bloc.dart';

import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/app_colors.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Helpers/network_constants.dart';
import 'package:techtime/Models/client/company.dart';
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
    final AppLocalizations _translator = AppLocalizations.of(context);
    final Size _size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(children: <Widget>[
      SafeArea(
        child: SizedBox(
          width: _size.width,
          child: Column(
            children: <Widget>[
              //Image Carousle for Branch View Start
              BlocListener<CompanyProfileBloc, CompanyProfileState>(
                listener: (context, state) {
                  if (state is CompanyProfileFinished &&
                      state.companyProfile.companyBranches.isNotEmpty &&
                      state.companyProfile.companyData.companyCoverImage !=
                          null) {
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
                      enlargeCenterPage: true),
                  items: imgList
                      .map((item) => InkWell(
                          onTap: () => Navigator.pushNamed(
                                  context, GalleryView.routeName, arguments: {
                                'imgList': imgList,
                                'companyName': widget.company.companyName
                              }),
                          child:
                              Image.network(NetworkConstants.baseUrl + item)))
                      .toList(),
                ),
              ),

              //Image Carousle for Branch View End
              //Branch logo, name and Rating Start.
              Row(
                children: [
                  const Spacer(),
                  Hero(
                      tag: widget.company.companyName,
                      child: CustomCircleAvatar(
                        height: 80,
                        width: 80,
                        image: widget.company.logo,
                      )),
                  const HorizontalGap(
                    width: defaultPadding / 4,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: _size.width * 0.6,
                        child: Text(
                          widget.company.companyName,
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                              fontWeight: FontWeight.bold, wordSpacing: 3.5),
                        ),
                      ),
                      const VerticalGap(
                        height: defaultPadding / 2,
                      ),
                      RatingBarIndicator(
                        rating: 5.00,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemSize: 14.0,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          icon: const Icon(Icons.favorite_border),
                          onPressed: () {}),
                    ],
                  ),
                  const Spacer()
                ],
              ),
              const VerticalGap(),
              //Branch logo, name and Rating End.
              TabBar(
                controller: _controller,
                indicatorColor: AppColors.primaryColor,
                isScrollable: true,
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
          ),
        ),
      ),
      BlocBuilder<CompanyProfileBloc, CompanyProfileState>(
          builder: (context, state) {
        if (state is CompanyProfileFinished) {
          return Expanded(
            flex: 3,
            child: SizedBox(
              width: double.infinity,
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _controller,
                children: <Widget>[
                  CompanyServices(
                    companyProfile: state.companyProfile,
                  ),
                  CompanyOffers(
                    companyProfile: state.companyProfile,
                  ),
                  CompanyBranchesScreen(
                    companyBranches: state.companyProfile.companyBranches,
                  ),
                  CompanyReviewsScreen(
                    reviews: state.companyProfile.companyReviews,
                  ),
                ],
              ),
            ),
          );
        }
        return SizedBox(
          height: _size.height * 0.3,
          child: const Center(
            child: SizedBox(
                height: 20, width: 20, child: CircularProgressIndicator()),
          ),
        );
      })
    ]));
  }
}
