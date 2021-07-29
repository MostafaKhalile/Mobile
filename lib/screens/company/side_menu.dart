import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:techtime/Controllers/Repositories/Auth/repository.dart';
import 'package:techtime/Controllers/providers/current_user_provider.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Models/client_profile.dart';
import 'package:techtime/Screens/Core/startupViews/language_selection_page.dart';
import 'package:techtime/Screens/Core/startupViews/loginScreen/login_page.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserProfile _currentUser =
        Provider.of<CurrentUserProvider>(context, listen: false).currentUser;
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/logo.png"),
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Transaction",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Task",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Documents",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Store",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Notification",
            svgSrc: "assets/icons/menu_notification.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Profile",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Settings",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {},
          ),
          DrawerListTile(
            press: () async {
              if (_currentUser != null) {
                final bool logOut = await buildShowDialog(
                    context, AppLocalizations.of(context));
                if (logOut) _logout(context);
              } else {
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginPage.routeName, (route) => false);
              }
            },
            title:
                AppLocalizations.of(context).translate("signOut").toUpperCase(),
            svgSrc: '',
          )
        ],
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    await AuthRepo().logout();
    Provider.of<CurrentUserProvider>(context, listen: false)
        .loadCurrentUser(); //TODO : add await here if lohin/Logout crashes
    Navigator.pushNamedAndRemoveUntil(
        context, LanguageSelectionPage.routeName, (route) => false);
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
              onPressed: () => Navigator.pop(context, true),
              child: Text(
                _translator.translate("confirm"),
                style: Theme.of(context).textTheme.button,
              ),
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

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key key,
    // For selecting those three line once press "Command+D"
    @required this.title,
    @required this.svgSrc,
    @required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white54),
      ),
    );
  }
}
