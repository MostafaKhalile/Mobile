import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techtime/Controllers/cubits/LocaleCubit/locale_cubit.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';

class ClientSignupPage extends StatefulWidget {
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
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
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  size: 30,
                                  color: Colors.black,
                                ))
                          ],
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
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
                        SizedBox(
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
                                    labelStyle: TextStyle(color: Colors.black)),
                              ),
                              SizedBox(
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
                                  labelStyle: TextStyle(color: Colors.black),
                                ),
                              ),
                              SizedBox(
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
                                  labelStyle: TextStyle(color: Colors.black),
                                ),
                              ),
                              SizedBox(
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
                                  labelStyle: TextStyle(color: Colors.black),
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
                              SizedBox(
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
                                  labelStyle: TextStyle(color: Colors.black),
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
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
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
