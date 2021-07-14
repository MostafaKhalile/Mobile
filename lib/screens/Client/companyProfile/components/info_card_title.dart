import 'package:flutter/material.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/widgets/core/horizontal_gap.dart';

class InfoCardHeader extends StatelessWidget {
  const InfoCardHeader({
    Key key,
    @required this.title,
    @required this.icon,
  }) : super(key: key);
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
      child: Row(
        children: [
          Icon(
            icon,
            size: 25,
          ),
          const HorizontalGap(
            width: defaultPadding / 4,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headline6,
          )
        ],
      ),
    );
  }
}
