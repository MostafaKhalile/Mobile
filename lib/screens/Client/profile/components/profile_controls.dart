import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:techtime/Controllers/cubits/LocaleCubit/locale_cubit.dart';
import 'package:techtime/Controllers/providers/current_user_provider.dart';
import 'package:techtime/Controllers/repositories/Auth/repository.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/colors.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Helpers/themes/dark_theme.dart';
import 'package:techtime/Helpers/themes/theme_model.dart';

import 'package:techtime/models/user.dart';
import 'package:techtime/screens/Client/contact/contact_us.dart';
import 'package:techtime/screens/Client/profileEdit/profile_edit.dart';
import 'package:techtime/screens/Client/walletScreen/wallet_screen.dart';
import 'package:techtime/screens/Core/startupViews/language_selection_page.dart';
import 'package:techtime/screens/Core/startupViews/loginScreen/login_page.dart';

class ProfileControls extends StatefulWidget {
  ProfileControls({
    Key key,
  }) : super(key: key);

  @override
  _ProfileControlsState createState() => _ProfileControlsState();
}

class _ProfileControlsState extends State<ProfileControls> {
  @override
  Widget build(BuildContext context) {
    User _currentUser = Provider.of<CurrentUserProvider>(context).currentUser;
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
                      .toUpperCase(), onTap: () {
                if (_currentUser != null) {
                  Navigator.pushNamed(
                    context,
                    ProfileEdit.routeName,
                  );
                } else {
                  _showToast(context);
                }
              }),
              //Wallet
              buildProfileListTile(context, _theme,
                  leading: Icons.account_balance_wallet, onTap: () {
                if (_currentUser != null) {
                  Navigator.pushNamed(context, WalletScreen.routeName);
                } else {
                  _showToast(context);
                }
              },
                  title: AppLocalizations.of(context)
                      .translate("myWallet")
                      .toUpperCase()),
              //language
              buildProfileListTile(
                context,
                _theme,
                onTap: () => _chooseLanguage(context),
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
                      .toUpperCase(),
                  onTap: () =>
                      Navigator.pushNamed(context, ContactUS.routeName)),
              // Signup or signout
              //
              ProfileListTile(
                  onTap: () async {
                    if (_currentUser != null) {
                      bool logOut = await buildShowDialog(
                          context, AppLocalizations.of(context));
                      if (logOut) _logout(context);
                    } else {
                      Navigator.pushNamedAndRemoveUntil(
                          context, LoginPage.routeName, (route) => false);
                    }
                  },
                  leading: Icon(
                    Icons.exit_to_app_outlined,
                    size: 30,
                  ),
                  // trailing: trailing,
                  title: buildLoginLogoutText(_currentUser, context, _theme))
            ],
          ),
        ),
      ),
    );
  }

  Text buildLoginLogoutText(
      User _currentUser, BuildContext context, ThemeData _theme) {
    return Text(
      _currentUser != null
          ? AppLocalizations.of(context).translate("signOut").toUpperCase()
          : "${AppLocalizations.of(context).translate("login").toUpperCase()} / ${AppLocalizations.of(context).translate("signup").toUpperCase()}",
      style: _theme.textTheme.subtitle2,
    );
  }

  _logout(context) {
    AuthRepo().logout();
    Provider.of<CurrentUserProvider>(context, listen: false).loadCurrentUser();
    Navigator.pushNamedAndRemoveUntil(
        context, LanguageSelectionPage.routeName, (route) => false);
  }

  _showToast(context) {
    Fluttertoast.showToast(
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        msg: AppLocalizations.of(context).translate("please_login_first"));
  }

  Future<void> _chooseLanguage(context) async {
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

  Future<bool> buildShowDialog(
      BuildContext context, AppLocalizations _translator) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(_translator.translate("confirm_signout")),
          actions: <Widget>[
            TextButton(
              child: Text(
                _translator.translate("confirm"),
                style: Theme.of(context).textTheme.button,
              ),
              onPressed: () => Navigator.pop(context, true),
            ),
            TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(
                  _translator.translate("cancel"),
                  style: Theme.of(context).textTheme.button,
                )),
          ],
        );
      },
    );
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
