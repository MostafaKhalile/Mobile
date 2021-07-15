import 'package:flutter/material.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Widgets/core/vertical_gab.dart';

class SubTitle extends StatelessWidget {
  const SubTitle({
    Key key,
    @required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Column(
        children: [
          const VerticalGap(
            height: defaultPadding / 2,
          ),
          Row(
            children: [
              Text(
                text,
                style: _theme.textTheme.subtitle1
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const VerticalGap(
            height: defaultPadding / 2,
          ),
        ],
      ),
    );
  }
}
