import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techtime/Controllers/blocs/client/ads_bloc/ads_bloc.dart';
import 'package:techtime/Helpers/APIUrls.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/colors.dart';
import 'package:techtime/Widgets/core/shimmer_effect.dart';

final List<dynamic> imgList = [
  {"image": 'assets/images/default_cover.png'},
  {"image": 'assets/images/default_cover.png'},
  {"image": 'assets/images/default_cover.png'},
  {"image": 'assets/images/default_cover.png'},
];
List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

class CarouselWithIndicator extends StatefulWidget {
  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;
  @override
  void initState() {
    BlocProvider.of<AdsBloc>(context).add(GetAdsAbove());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<AdsBloc, AdsState>(builder: (context, state) {
      if (state is AdsLoaded) {
        if (state.ads.length > 0) {
          return Stack(children: <Widget>[
            CarouselSlider(
                items: buildCarouselItems(size, state.ads),
                options: CarouselOptions(
                  onPageChanged: (index, _) {
                    setState(() {
                      _current = index;
                    });
                  },
                  height: size.height * 0.25,
                  autoPlay: true,
                  viewportFraction: 1.0,
                  aspectRatio: MediaQuery.of(context).size.aspectRatio,
                )),
            Positioned(
                bottom: 10,
                right: 0,
                left: 0,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: map<Widget>(
                      state.ads,
                      (index, url) {
                        return Container(
                          width: 12.0,
                          height: 12.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _current == index
                                  ? KPrimaryColor
                                  : Colors.grey[600]),
                        );
                      },
                    )))
          ]);
        } else {
          return Container();
        }
      }
      return ShimmerEffect(
          child: Container(
        height: size.height * 0.25,
        width: double.infinity,
        color: Colors.white,
      ));
    });
  }

  List<Widget> buildCarouselItems(size, items) {
    return map<Widget>(
      items,
      (index, ad) {
        return Container(
          height: size.height * 0.25,
          child: Stack(children: <Widget>[
            (ad.image != null)
                ? Image.network(
                    "${KAPIURL + ad.image}",
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: size.height * 0.25,
                  )
                : Image.asset(
                    KPlaceHolderCover,
                  ),
            // Positioned(
            //   bottom: 0.0,
            //   left: 0.0,
            //   right: 0.0,
            //   child: Container(
            //     decoration: BoxDecoration(
            //       gradient: LinearGradient(
            //         colors: [
            //           Color.fromARGB(200, 0, 0, 0),
            //           Color.fromARGB(0, 0, 0, 0)
            //         ],
            //         begin: Alignment.bottomCenter,
            //         end: Alignment.topCenter,
            //       ),
            //     ),
            //     padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            //     child: Text(
            //       'No. $index image',
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 40.0,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ),
            // ),
          ]),
        );
      },
    );
  }
}
