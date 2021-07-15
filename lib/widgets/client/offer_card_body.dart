import 'package:flutter/material.dart';

import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/network_constants.dart';

class OfferCardBody extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final String price;
  const OfferCardBody({
    Key key,
    this.image,
    this.title,
    this.subtitle,
    this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(defaultPadding),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: (image != null)
                        ? NetworkImage(NetworkConstants.baseUrl + image)
                            as ImageProvider
                        : const AssetImage(
                            placeHolderImage,
                          ))),
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: RichText(
            textAlign: TextAlign.end,
            text: TextSpan(
              text: "$title\n",
              style: _theme.textTheme.subtitle1
                  .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                    text: subtitle,
                    style: _theme.textTheme.headline6
                        .copyWith(color: Colors.white)),
                TextSpan(
                    text: price,
                    style: _theme.textTheme.headline6
                        .copyWith(color: Colors.white)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
