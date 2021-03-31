import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:techtime/Helpers/app_consts.dart';

class GalleryView extends StatelessWidget {
  static const String routeName = "/gallery_view";
  static List imgList = [
    Image.asset(KPlaceHolderCover),
    Image.asset(KPlaceHolderCover),
    Image.asset(KPlaceHolderCover)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fullscreen sliding carousel demo')),
      body: Builder(
        builder: (context) {
          final double height = MediaQuery.of(context).size.height;
          return CarouselSlider(
            options: CarouselOptions(
              height: height,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              // autoPlay: false,
            ),
            items: imgList
                .map((item) => Container(
                      child: Center(
                          child: Image.network(
                        item,
                        fit: BoxFit.cover,
                        height: height,
                      )),
                    ))
                .toList(),
          );
        },
      ),
    );
  }
}
