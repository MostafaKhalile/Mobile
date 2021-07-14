import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:techtime/Controllers/BLoCs/core/notificationsBloc/notifications_bloc.dart';
import 'package:techtime/Controllers/Repositories/Auth/repository.dart';

import 'package:techtime/Helpers/enums.dart';
import 'package:techtime/Helpers/network_constants.dart';
import 'package:techtime/Screens/Core/notifications/notifications.dart';
import 'package:techtime/screens/Client/home_page.dart';
import 'package:techtime/screens/Core/startupViews/language_selection_page.dart';
import 'package:techtime/screens/company/company_placeholder.dart';

import '../../../main.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isSignedIn;
  UserRole _userRole;
  AuthRepo _authRepo;
  NotificationsBloc notificationsBloc;

  @override
  void initState() {
    notificationsBloc = context.read<NotificationsBloc>();
    _authRepo = AuthRepo();
    _isSignedIn = _authRepo.currentUserToken != null;
    _userRole = _authRepo.userType;
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (message != null) {
        print(message);
        //new line for routing on message ;

      }
    });
    Future.delayed(const Duration(seconds: 1), () async {
      Navigator.pushReplacementNamed(
        context,
        _isSignedIn
            ? _userRole == UserRole.client
                ? ClientHomePage.routeName
                : CompanyPlaceholder.routeName
            : LanguageSelectionPage.routeName,
      );
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      Navigator.pushNamed(
        context,
        Notifications.routeName,
      );
      print(message);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final RemoteNotification notification = message.notification;
      final AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        notificationsBloc.add(const GetAllUserNotifications());
        Navigator.pushNamed(context, Notifications.routeName);
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: 'launch_background',
              ),
            ));
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/background.png",
                ),
                fit: BoxFit.fill),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
      ],
    ));
  }
}
