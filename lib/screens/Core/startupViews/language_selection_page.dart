import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtime/Controllers/Cubits/LocaleCubit/locale_cubit.dart';

import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Helpers/network_constants.dart';

class LanguageSelectionPage extends StatefulWidget {
  static const String routeName = '/languageSelection';
  @override
  _LanguageSelectionPageState createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: Container(height: 80),
            ),
            Expanded(
              child: SizedBox(
                height: 80,
                child: Column(
                  children: [
                    SvgPicture.asset("assets/svg/logo.svg"),
                    const Text(NetworkConstants.appName,
                        style: TextStyle(
                            fontSize: 37,
                            color: Colors.black,
                            fontWeight: FontWeight.bold))
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        onPressed: () {
                          BlocProvider.of<LocaleCubit>(context).toArabic();
                          Navigator.of(context).pushReplacementNamed(
                            '/loginModerator',
                          );
                        },
                        child: Text(
                          AppLocalizations.of(context)!.translate('arabic')!,
                          style: Theme.of(context).textTheme.button,
                        ),
                      )),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      onPressed: () {
                        BlocProvider.of<LocaleCubit>(context).toEnglish();
                        Navigator.of(context).pushReplacementNamed(
                          '/loginModerator',
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.translate('english')!,
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
