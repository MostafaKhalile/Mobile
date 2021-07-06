import 'package:flutter/material.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';

class ClientSignupPage extends StatefulWidget {
  static const String routeName = "/signUp";
  @override
  _ClientSignupPageState createState() => _ClientSignupPageState();
}

class _ClientSignupPageState extends State<ClientSignupPage> {
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
              width: size.width,
              height: size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/images/background.png",
                    ),
                    fit: BoxFit.fill),
              ),
              child: Container(
                  height: size.height,
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.1,
                      vertical: size.height * 0.1),
                  child: Column(children: <Widget>[
                    Row(
                      children: [
                        IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(
                              Icons.arrow_back_ios_rounded,
                              size: 30,
                              color: Colors.black,
                            ))
                      ],
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          children: [
                            Text(
                                AppLocalizations.of(context)
                                    .translate('signup'),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    .copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    )),
                          ],
                        )),
                    const SizedBox(
                      height: 50,
                    ),
                    Form(
                      child: Column(
                        children: [
                          TextField(
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(color: Colors.black),
                            decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)
                                    .translate('userName'),
                                labelStyle:
                                    const TextStyle(color: Colors.black)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)
                                  .translate('mobile'),
                              labelStyle: const TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)
                                  .translate('email'),
                              labelStyle: const TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(color: Colors.black),
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)
                                  .translate('password'),
                              labelStyle: const TextStyle(color: Colors.black),
                              suffixIcon: IconButton(
                                onPressed: () => _toggle(),
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(color: Colors.black),
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)
                                  .translate('Repassword'),
                              labelStyle: const TextStyle(color: Colors.black),
                              suffixIcon: IconButton(
                                onPressed: () => _toggle(),
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              // ignore: deprecated_member_use
                              child: RaisedButton(
                                onPressed: () =>
                                    Navigator.pushNamed(context, "/sms"),
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('signup'),
                                  style: Theme.of(context).textTheme.button,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ])))),
    );
  }
}
