import 'package:flutter/material.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/colors.dart';

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
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [KPrimaryColor, KSecondryColor]),
          borderRadius: BorderRadius.circular(KDefaultPadding)),
      child: child,
    );
  }
}
