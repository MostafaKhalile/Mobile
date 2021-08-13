import 'package:flutter/material.dart';

import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/network_constants.dart';

class OfferCardBody extends StatelessWidget {
  final String? image;
  final String? title;
  final String? subtitle;
  final String? hint;
  const OfferCardBody({
    Key? key,
    this.image,
    this.title,
    this.subtitle,
    this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(defaultPadding),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: (image != null)
                        ? NetworkImage(NetworkConstants.baseUrl + image!)
                            as ImageProvider
                        : const AssetImage(
                            placeHolderImage,
                          ))),
          ),
        ),
        // const Spacer(),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: RichText(
              // textAlign: TextAlign.start,
              text: TextSpan(
                text: "$title\n",
                style: _theme.textTheme.subtitle2!
                    .copyWith(fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                      text: "$hint\n",
                      style: _theme.textTheme.caption!
                          .copyWith(color: Colors.white)),
                  TextSpan(
                      text: "$subtitle\n",
                      style: _theme.textTheme.bodyText2!
                          .copyWith(color: Colors.white)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
