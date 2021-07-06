import 'package:flutter/material.dart';

import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/app_colors.dart';
import 'package:techtime/Helpers/network_constants.dart';

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
    final ThemeData _theme = Theme.of(context);
    return Container(
      width: width ?? 80.0,
      height: height ?? 80.0,
      margin: const EdgeInsets.all(defaultPadding / 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _theme.scaffoldBackgroundColor,
        border: Border.all(width: 2, color: AppColors.primaryColor),
        image: DecorationImage(
            image: image != null
                ? NetworkImage(NetworkConstants.baseUrl + image)
                    as ImageProvider
                : const AssetImage("assets/images/default_logo.png"),
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
