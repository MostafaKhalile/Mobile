import 'package:flutter/material.dart';
import 'package:techtime/constants/app_consts.dart';
import 'package:techtime/data/models/AppConfgModels/app_localizations_delegates.dart';

class SectionHeader extends StatelessWidget {
  final Widget title;

  const SectionHeader({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
      child: Container(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          title ?? Container(),
          Row(
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
          )
        ]),
      ),
    );
  }
}
