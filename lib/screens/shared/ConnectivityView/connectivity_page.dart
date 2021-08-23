import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:techtime/Controllers/Cubits/NetworkCubit/internet_cubit.dart';

import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';

class ConnectivityPage extends StatefulWidget {
  final Widget parent;

  const ConnectivityPage({Key? key, required this.parent}) : super(key: key);
  @override
  _ConnectivityPageState createState() => _ConnectivityPageState();
}

class _ConnectivityPageState extends State<ConnectivityPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final AppLocalizations? _translator = AppLocalizations.of(context);
    return BlocConsumer<InternetCubit, InternetState>(
        listener: (context, state) {
      if (state is InternetConnected) Navigator.pop(context);
    }, builder: (context, state) {
      return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
              backgroundColor: _theme.scaffoldBackgroundColor,
              body: SizedBox(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Center(
                      child: Icon(
                    Icons.cloud_off,
                    size: 80,
                  )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: RichText(
                      text: TextSpan(
                          style: _theme.textTheme.headline5,
                          text:
                              "${_translator!.translate("looks_like_you're_offline")} \n",
                          children: [
                            TextSpan(
                                style: _theme.textTheme.subtitle1,
                                text: _translator.translate(
                                    "you_will_use_our_services_when_you_back_online")),
                          ]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ))));
    });
  }
}
