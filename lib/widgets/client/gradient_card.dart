import 'package:flutter/material.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/app_colors.dart';

class GradientCard extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  const GradientCard({
    Key key,
    this.width,
    this.height,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primaryColor, AppColors.secondryColor]),
          borderRadius: BorderRadius.circular(defaultPadding)),
      child: child,
    );
  }
}
