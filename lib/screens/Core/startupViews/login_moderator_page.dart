import 'package:flutter/material.dart';
import 'package:techtime/Helpers/api_urls.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Screens/Core/startupViews/client_signup_page.dart';
import 'package:techtime/screens/Core/ConnectivityView/network_sensitive.dart';

class LoginModeratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NetworkSensitive(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                  top: 25,
                  right: 10,
                  child: TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/clientHome'),
                      child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context).translate('skip'),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.black,
                              )
                            ],
                          )))),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const Spacer(),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/logo.png"),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(KAppName,
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              // ignore: deprecated_member_use
                              child: RaisedButton(
                                onPressed: () =>
                                    Navigator.pushNamed(context, '/login'),
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('login'),
                                  style: Theme.of(context).textTheme.button,
                                ),
                              )),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            // ignore: deprecated_member_use
                            child: RaisedButton(
                              onPressed: () => Navigator.pushNamed(
                                  context, ClientSignupPage.routeName),
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('signup'),
                                style: Theme.of(context).textTheme.button,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            // ignore: deprecated_member_use
                            child: RaisedButton(
                              onPressed: () {},
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('companyRegister'),
                                style: Theme.of(context)
                                    .textTheme
                                    .button
                                    .copyWith(fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
