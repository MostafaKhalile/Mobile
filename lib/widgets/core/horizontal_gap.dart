import 'package:flutter/material.dart';
import 'package:techtime/Helpers/app_consts.dart';

class HorizontalGap extends StatelessWidget {
  final double? width;
  const HorizontalGap({
    Key? key,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? defaultPadding,
    );
  }
}
