import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techtime/Theme/app_consts.dart';
import 'package:techtime/models/app_language_model.dart';
import 'package:techtime/models/app_localizations_delegates.dart';
import 'package:techtime/models/theme_model.dart';

class StartupPage extends StatefulWidget {
  @override
  _StartupPageState createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage> {
  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context);
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(height: 80),
              flex: 1,
            ),
            Expanded(
              child: Container(
                height: 80,
                child: Column(
                  children: [
                    Image.asset("assets/images/logo.png"),
                    Text(KAppName,
                        style: TextStyle(
                            fontSize: 37,
                            color: Colors.black,
                            fontWeight: FontWeight.bold))
                  ],
                ),
              ),
              flex: 1,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: RaisedButton(
                        onPressed: () {
                          appLanguage.changeLanguage(Locale("ar"));
                        },
                        child: Text(
                            AppLocalizations.of(context).translate('arabic')),
                      )),
                  SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: RaisedButton(
                      onPressed: () {
                        appLanguage.changeLanguage(Locale("en"));
                      },
                      child: Text(
                          AppLocalizations.of(context).translate('english')),
                    ),
                  ),
                  // RaisedButton(
                  //     child: Text("Change Theme"),
                  //     onPressed: () {
                  //       Provider.of<ThemeModel>(context, listen: false)
                  //           .toggleTheme();
                  //     })
                ],
              ),
              flex: 1,
            ),
          ],
        ),
      ),
    ));
  }
}
