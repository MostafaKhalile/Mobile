import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({Key key, this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    return Shimmer.fromColors(
        baseColor: _theme.highlightColor,
        highlightColor: _theme.hoverColor.withOpacity(0.2),
        direction: ShimmerDirection.ltr,
        child: child);
  }
}
