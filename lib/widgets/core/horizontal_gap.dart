import 'package:flutter/material.dart';
import 'package:techtime/Helpers/app_consts.dart';

class HorizontalGap extends StatelessWidget {
  final height;
  const HorizontalGap({
    Key key,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: height ?? KDefaultPadding,
    );
  }
}
