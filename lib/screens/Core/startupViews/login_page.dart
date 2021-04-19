import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtime/Controllers/cubits/LocaleCubit/locale_cubit.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/images/background.png",
                    ),
                    fit: BoxFit.fill),
              ),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: <
                      Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BlocBuilder<LocaleCubit, LocaleState>(
                      builder: (context, state) {
                        return Padding(
                          padding:
                              const EdgeInsets.only(top: KdefaultPadding * 2),
                          child: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(
                                state.locale == Locale("ar")
                                    ? Icons.arrow_forward_ios_rounded
                                    : Icons.arrow_back_ios_rounded,
                                size: 30,
                                color: Colors.black,
                              )),
                        );
                      },
                    )
                  ],
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.of(context).translate('login'),
                          style: Theme.of(context).textTheme.headline4.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              )),
                    ],
                  ),
                ),
                Expanded(
                  child: Form(
                      child: Container(
                    child: Column(
                      children: [
                        TextField(
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: Colors.black),
                          decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)
                                  .translate('mobile/email'),
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
                        Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            // ignore: deprecated_member_use
                            child: RaisedButton(
                              onPressed: () =>
                                  Navigator.pushNamed(context, "/sms"),
                              child: Text(
                                AppLocalizations.of(context).translate('login'),
                                style: Theme.of(context).textTheme.button,
                              ),
                            )),
                      ],
                    ),
                  )),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                          child: Divider(
                        thickness: 2.0,
                        color: Colors.black,
                        endIndent: 20,
                        indent: 50,
                      )),
                      Text("OR",
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      Expanded(
                          child: Divider(
                        thickness: 2.0,
                        color: Colors.black,
                        endIndent: 50,
                        indent: 20,
                      )),
                    ]),
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // ignore: deprecated_member_use
                        RaisedButton(
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/Facebook.svg',
                                  height: 25,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  AppLocalizations.of(context)
                                      .translate('facebookLogin'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .button
                                      .copyWith(fontSize: 14),
                                ),
                              ],
                            )),
                        // ignore: deprecated_member_use
                        RaisedButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/svg/Google+.svg',
                                height: 25,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                AppLocalizations.of(context)
                                    .translate('googleLogin'),
                                style: Theme.of(context)
                                    .textTheme
                                    .button
                                    .copyWith(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('forgotPassword'),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                              ),
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                    AppLocalizations.of(context)
                                        .translate('newAccount'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        .copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700))),
                          ],
                        )
                      ]),
                ),
              ]))),
    );
  }
}
