import 'package:techtime/Helpers/app_colors.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Screens/shared/startupViews/loginScreen/login_page.dart';
import 'package:flutter/material.dart';

class GuestUserAccessDeniedScreen extends StatelessWidget {
  const GuestUserAccessDeniedScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);

    final AppLocalizations _translator = AppLocalizations.of(context)!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _translator.translate("please_login_first")!,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        TextButton(
          onPressed: () => Navigator.pushNamed(
            context,
            LoginPage.routeName,
          ),
          child: Text(
            "${AppLocalizations.of(context)!.translate("login")!.toUpperCase()} / ${AppLocalizations.of(context)!.translate("signup")!.toUpperCase()}",
            style: _theme.textTheme.subtitle2!
                .copyWith(color: AppColors.primaryColor),
          ),
        )
      ],
    );
  }
}
