import 'package:flutter/material.dart';

class OfferCardBody extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  const OfferCardBody({
    Key key,
    @required ThemeData theme,
    this.image,
    this.title,
    this.subtitle,
  })  : _theme = theme,
        super(key: key);

  final ThemeData _theme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            text: title,
            style: _theme.textTheme.subtitle1
                .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
            children: <TextSpan>[
              TextSpan(
                  text: subtitle,
                  style:
                      _theme.textTheme.headline6.copyWith(color: Colors.white)),
            ],
          ),
        ),
        Spacer(),
        Image.asset(
          image,
        )
      ],
    );
  }
}
