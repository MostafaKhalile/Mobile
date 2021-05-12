import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:techtime/Helpers/APIUrls.dart';

class GalleryView extends StatelessWidget {
  static const String routeName = "/gallery_view";
  final String companyName;
  final List<String> imgList;

  const GalleryView({Key key, this.imgList, this.companyName})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _theme.scaffoldBackgroundColor,
        title: Text(
          companyName,
          style: _theme.textTheme.headline6,
        ),
      ),
      body: Builder(
        builder: (context) {
          final double height = MediaQuery.of(context).size.height;
          return CarouselSlider(
            options: CarouselOptions(
              height: height,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              pauseAutoPlayOnManualNavigate: true,
              autoPlay: true,
            ),
            items: imgList
                .map((item) => Container(
                      child: Center(
                          child: Image.network(
                        KAPIURL + item,
                        fit: BoxFit.fill,
                        // height: height,
                      )),
                    ))
                .toList(),
          );
        },
      ),
    );
  }
}
