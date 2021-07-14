import 'package:flutter/material.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/app_colors.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/widgets/core/vertical_gab.dart';

import 'info_card_title.dart';

class BranchAddressContainer extends StatelessWidget {
  const BranchAddressContainer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations _translator = AppLocalizations.of(context);
    final ThemeData _theme = Theme.of(context);
    final Size _size = MediaQuery.of(context).size;
    return SizedBox(
        width: _size.width,
        child: Card(
            elevation: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  vertical: defaultPadding, horizontal: 5),
              child: Wrap(
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              InfoCardHeader(
                                title: _translator.translate("address"),
                                icon: Icons.location_on_outlined,
                              ),
                              const VerticalGap(
                                height: defaultPadding / 2,
                              ),
                              SizedBox(
                                width: _size.width * 0.55,
                                child: Text(
                                    ' world! world! world! world! world! world! world! world! world! world! world! world! world! world! world! world! world!',
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.fade,
                                    maxLines: 2,
                                    style: _theme.textTheme.caption),
                              ),
                              const VerticalGap(),
                              SizedBox(
                                  width: _size.width * 0.55,
                                  child: Text(
                                    _translator.translate("moreBranches"),
                                    textAlign: TextAlign.start,
                                    style: _theme.textTheme.subtitle2,
                                  ))
                            ],
                          )),
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipOval(
                            child: Material(
                              color: AppColors.primaryColor, // button color
                              child: InkWell(
                                onTap: () {},
                                child: SizedBox(
                                    width: 56,
                                    height: 56,
                                    child: RotationTransition(
                                        turns: const AlwaysStoppedAnimation(
                                            45 / 360),
                                        child: Icon(
                                          Icons.navigation_sharp,
                                          size: 25,
                                          color: _theme.backgroundColor,
                                        ))),
                              ),
                            ),
                          ),
                          const VerticalGap(),
                          // ignore: deprecated_member_use
                          FlatButton(
                            onPressed: () {},
                            child: Text(
                              _translator.translate("seeAll"),
                              style: _theme.textTheme.button,
                            ),
                          )
                        ],
                      ))
                    ],
                  )
                ],
              ),
            )));
  }
}
