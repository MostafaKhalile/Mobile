import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtime/Helpers/app_colors.dart';

class CircleIcon extends StatelessWidget {
  const CircleIcon({
    Key key,
    @required this.icon,
  }) : super(key: key);
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 35,
        width: 35,
        margin: const EdgeInsets.all(3),
        decoration: const BoxDecoration(
            color: AppColors.darkGreyColor,
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            icon,
          ),
        ));
  }
}
