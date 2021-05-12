import 'package:flutter/material.dart';
import 'package:techtime/Helpers/app_consts.dart';

class SocialButton extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  final Color backgroundColor;
  const SocialButton({
    this.width,
    this.height,
    this.child,
    this.backgroundColor,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: Padding(
          padding: const EdgeInsets.all(KdefaultPadding / 2), child: child),
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
                offset: Offset(2, 3), blurRadius: 10, color: Colors.black45)
          ],
          borderRadius: BorderRadius.all(Radius.circular(50))),
    );
  }
}
