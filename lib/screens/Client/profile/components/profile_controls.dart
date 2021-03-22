import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:techtime/Controllers/cubits/LocaleCubit/locale_cubit.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/colors.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Helpers/themes/dark_theme.dart';
import 'package:techtime/Helpers/themes/theme_model.dart';

class ProfileControls extends StatelessWidget {
  ProfileControls({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appTheme = Provider.of<ThemeModel>(context);
    ThemeData _theme = Theme.of(context);
    return Expanded(
      flex: 2,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: KDefaultPadding),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              //Profile
              buildProfileListTile(context, _theme,
                  leading: Icons.person_outline_rounded,
                  title: AppLocalizations.of(context)
                      .translate("profile")
                      .toUpperCase()),
              //Wallet
              buildProfileListTile(context, _theme,
                  leading: Icons.account_balance_wallet,
                  title: AppLocalizations.of(context)
                      .translate("myWallet")
                      .toUpperCase()),
              //language
              buildProfileListTile(
                context,
                _theme,
                onTap: () => _askedToLead(context),
                leading: Icons.language,
                title: AppLocalizations.of(context)
                    .translate("language")
                    .toUpperCase(),
              ),
              // darkMode
              buildProfileListTile(
                context,
                _theme,
                leading: Icons.brightness_3_sharp,
                title: AppLocalizations.of(context)
                    .translate("darkMode")
                    .toUpperCase(),
                trailing: Switch(
                  activeColor: KPrimaryColor,
                  // trackColor: KPrimaryColor,
                  value: appTheme.currentTheme == darkTheme ? true : false,
                  onChanged: (value) =>
                      Provider.of<ThemeModel>(context, listen: false)
                          .toggleTheme(),
                ),
              ),
              // Contact us
              buildProfileListTile(context, _theme,
                  leading: Icons.mail,
                  title: AppLocalizations.of(context)
                      .translate("contactUs")
                      .toUpperCase()),
              // Signup or signout
              buildProfileListTile(context, _theme,
                  leading: Icons.exit_to_app_outlined,
                  title: AppLocalizations.of(context)
                      .translate("signOut")
                      .toUpperCase()),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _askedToLead(context) async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(
              AppLocalizations.of(context).translate("changeLanguage"),
              style: Theme.of(context).textTheme.headline6,
            ),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  BlocProvider.of<LocaleCubit>(context).toArabic();
                },
                child: Text(
                  AppLocalizations.of(context).translate("arabic"),
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  BlocProvider.of<LocaleCubit>(context).toEnglish();
                },
                child: Text(
                  AppLocalizations.of(context).translate("english"),
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
            ],
          );
        })) {
    }
  }

  ProfileListTile buildProfileListTile(BuildContext context, ThemeData _theme,
      {IconData leading, String title, Widget trailing, Function onTap}) {
    return ProfileListTile(
        onTap: onTap,
        leading: Icon(
          leading,
          size: 30,
        ),
        trailing: trailing,
        title: Text(
          title ?? "",
          style: _theme.textTheme.subtitle2,
        ));
  }
}

class ProfileListTile extends StatelessWidget {
  final Widget title;
  final Widget leading;
  final Widget trailing;
  final Function onTap;

  const ProfileListTile({
    Key key,
    this.title,
    this.leading,
    this.trailing,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: leading ??
              Container(
                width: 0,
              ),
          title: title ??
              Container(
                width: 0,
              ),
          trailing: trailing ??
              Container(
                width: 0,
              ),
        ),
        Divider(
          height: KDefaultPadding / 2,
          thickness: 3,
          indent: 10,
          endIndent: 10,
        ),
      ],
    );
  }
}
