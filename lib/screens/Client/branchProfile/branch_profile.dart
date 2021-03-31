import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/widgets/core/gallery_view.dart';

class BranchProfile extends StatelessWidget {
  static const String routeName = "/branch_profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                ),
                items: [
                  InkWell(
                      onTap: () =>
                          Navigator.pushNamed(context, GalleryView.routeName),
                      child: Image.asset(KPlaceHolderCover)),
                  InkWell(
                      onTap: () =>
                          Navigator.pushNamed(context, GalleryView.routeName),
                      child: Image.asset(KPlaceHolderCover)),
                  InkWell(
                      onTap: () =>
                          Navigator.pushNamed(context, GalleryView.routeName),
                      child: Image.asset(KPlaceHolderCover)),
                ],
              ),
            ],
          )),
    );
  }
}
