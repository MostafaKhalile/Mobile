import 'package:flutter/material.dart';

import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/network_constants.dart';

class FooterCard extends StatelessWidget {
  const FooterCard({
    Key key,
    @required this.width,
    @required this.height,
    this.bgImage,
    this.child,
  }) : super(key: key);

  final double width;
  final double height;
  final String bgImage;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Container(
      width: width * 0.90,
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
      decoration: BoxDecoration(
          image: DecorationImage(
            image: bgImage != null
                ? NetworkImage(
                    NetworkConstants.baseUrl + bgImage,
                  ) as ImageProvider
                : const AssetImage(placeHolderCover),
            fit: BoxFit.fill,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(defaultRadius),
          ),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Colors.black38,
              offset: Offset(0, 5),
              blurRadius: 10.0,
            )
          ]),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2.0),
              borderRadius: const BorderRadius.all(
                Radius.circular(defaultRadius),
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                height: 110,
                width: width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: _theme.accentColor, width: 0.2),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(defaultRadius))),
                child: child ?? Container(),
              ))
        ],
      ),
    );
  }
}
