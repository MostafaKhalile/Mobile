import 'package:flutter/material.dart';
import 'package:techtime/Helpers/api_urls.dart';
import 'package:techtime/Helpers/app_consts.dart';

class OfferCardBody extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final String price;
  const OfferCardBody({
    Key key,
    @required ThemeData theme,
    this.image,
    this.title,
    this.subtitle,
    this.price,
  })  : _theme = theme,
        super(key: key);

  final ThemeData _theme;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RichText(
          text: TextSpan(
            text: "$title\n",
            style: _theme.textTheme.subtitle1
                .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
            children: <TextSpan>[
              TextSpan(
                  text: subtitle,
                  style:
                      _theme.textTheme.headline6.copyWith(color: Colors.white)),
              TextSpan(
                  text: price,
                  style:
                      _theme.textTheme.headline6.copyWith(color: Colors.white)),
            ],
          ),
        ),
        const Spacer(),
        if (image != null) Image.network(KAPIURL + image) else Image.asset(
                KPlaceHolderImage,
              )
      ],
    );
  }
}
