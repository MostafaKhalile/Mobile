import 'package:flutter/material.dart';
import 'package:techtime/Helpers/app_consts.dart';

class VerticalGap extends StatelessWidget {
  final double height;
  const VerticalGap({
    Key key,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? KDefaultPadding,
    );
  }
}
