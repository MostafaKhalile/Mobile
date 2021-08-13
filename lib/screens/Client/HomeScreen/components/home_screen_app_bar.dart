import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/app_colors.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';

import 'package:techtime/Helpers/themes/dark_theme.dart';
import 'package:techtime/Helpers/themes/theme_model.dart';

class ClientHomeScreenAppBar extends StatelessWidget {
  final ThemeModel appTheme = ThemeModel();
  ClientHomeScreenAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColorDark,
      centerTitle: false,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Text("${AppLocalizations.of(context)!.translate('hello')} User",
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: AppColors.primaryColor)),
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.translate('yourLocation')!,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(color: AppColors.darkGreyColor),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Row(children: [
                            const Icon(
                              Icons.location_on_outlined,
                            ),
                            Text(AppLocalizations.of(context)!.translate('Alex')!,
                                style: Theme.of(context).textTheme.headline5)
                          ])
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.brightness_5),
                      Switch(
                        activeColor: AppColors.primaryColor,
                        // trackColor: AppColors.primaryColor,
                        value: appTheme.currentTheme == darkTheme || false,
                        onChanged: (value) => appTheme.toggleTheme(),
                      ),
                      const Icon(Icons.brightness_3_sharp)
                    ],
                  )
                ],
              ))),
      actions: [
        Padding(
          padding: const EdgeInsets.all(defaultPadding / 8),
          child: IconButton(
            icon: Icon(
              Icons.notifications_none_outlined,
              // size: 26,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(defaultPadding / 8),
          child: IconButton(
            icon: SvgPicture.asset(
              "assets/svg/calendar.svg",
              color: Theme.of(context).iconTheme.color,
              // height: 16,
            ),
            onPressed: () {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(defaultPadding / 8),
          child: IconButton(
            icon: SvgPicture.asset(
              "assets/svg/favorites.svg",
              color: Theme.of(context).iconTheme.color,
              // height: 16,
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
