import 'package:flutter/material.dart';
import 'package:techtime/Helpers/colors.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';

class SectionHeader extends StatelessWidget {
  final Widget title;
  final Function pressed;

  const SectionHeader({Key key, this.title, this.pressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
      child: Container(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          title ?? Container(),
          InkWell(
              onTap: pressed,
              child: Row(
                children: [
                  Text(
                    AppLocalizations.of(context).translate('viewAll'),
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                          color: KPrimaryColor,
                        ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: KPrimaryColor,
                  )
                ],
              ))
        ]),
      ),
    );
  }
}
