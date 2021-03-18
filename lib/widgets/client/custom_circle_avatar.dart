import 'package:flutter/material.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/colors.dart';

class CustomCircleAvatar extends StatelessWidget {
  final double width;
  final double height;
  const CustomCircleAvatar({
    Key key,
    @required this.image,
    this.width,
    this.height,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    return Container(
      width: width ?? 80.0,
      height: height ?? 80.0,
      margin: EdgeInsets.all(KdefaultPadding / 4),
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        color: _theme.scaffoldBackgroundColor,
        border: Border.all(width: 2, color: KPrimaryColor),
        image: DecorationImage(
            image: image != null
                ? NetworkImage(image)
                : AssetImage("assets/images/default_logo.png"),
            fit: BoxFit.cover),
        boxShadow: [
          BoxShadow(
            color: _theme.shadowColor.withOpacity(0.3),
          ),
          BoxShadow(
            color: _theme.scaffoldBackgroundColor,
            spreadRadius: -12.0,
            blurRadius: 12.0,
          ),
        ],
      ),
    );
  }
}
