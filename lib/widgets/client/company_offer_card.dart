import 'package:flutter/material.dart';
import 'package:techtime/Helpers/app_consts.dart';

class CompanyOfferCard extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  final VoidCallback onClick;
  const CompanyOfferCard({
    Key key,
    this.width,
    this.height,
    this.child,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        height: height,
        width: width,
        // padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
            ),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.black, Colors.black.withOpacity(0.9)]),
            borderRadius: BorderRadius.circular(defaultPadding)),
        child: child,
      ),
    );
  }
}
