import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtime/constants/app_consts.dart';
import 'package:techtime/data/models/AppConfgModels/app_localizations_delegates.dart';
import 'package:techtime/data/models/AppConfgModels/theme_model.dart';
import 'package:techtime/presentation/themes/dark_theme.dart';

class ClientHomeScreenAppBar extends StatelessWidget {
  final ThemeModel appTheme;
  const ClientHomeScreenAppBar({
    Key key,
    this.appTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColorDark,
      centerTitle: false,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Text("${AppLocalizations.of(context).translate('hello')} User",
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(color: KPrimaryColor)),
      bottom: PreferredSize(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        AppLocalizations.of(context).translate('yourLocation'),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            .copyWith(color: KDarkGreyColor),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Row(children: [
                            Icon(
                              Icons.location_on_outlined,
                            ),
                            Text(AppLocalizations.of(context).translate('Alex'),
                                style: Theme.of(context).textTheme.headline5)
                          ])
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.brightness_5),
                      Switch(
                        activeColor: KPrimaryColor,
                        // trackColor: KPrimaryColor,
                        value:
                            appTheme.currentTheme == darkTheme ? true : false,
                        onChanged: (value) => appTheme.toggleTheme(),
                      ),
                      Icon(Icons.brightness_3_sharp)
                    ],
                  )
                ],
              )),
          preferredSize: Size.fromHeight(60.0)),
      actions: [
        Padding(
          padding: const EdgeInsets.all(KDefaultPadding / 8),
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
          padding: const EdgeInsets.all(KDefaultPadding / 8),
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
          padding: const EdgeInsets.all(KDefaultPadding / 8),
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
