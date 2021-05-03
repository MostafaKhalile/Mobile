import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:techtime/Controllers/repositories/Auth/repository.dart';
import 'package:techtime/Helpers/APIUrls.dart';
import 'package:techtime/Helpers/enums.dart';
import 'package:techtime/screens/Client/home_page.dart';
import 'package:techtime/screens/Core/startupViews/language_selection_page.dart';
import 'package:techtime/screens/company/company_placeholder.dart';

import '../../../main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isSignedIn;
  UserRole _userRole;
  AuthRepo _authRepo;
  @override
  void initState() {
    _authRepo = AuthRepo();
    _isSignedIn = _authRepo.currentUserToken != null;
    _userRole = _authRepo.userType;
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (message != null) {
        print(message);
      }
      Future.delayed(Duration(seconds: 1), () async {
        Navigator.pushNamed(
          context,
          _isSignedIn
              ? _userRole == UserRole.client
                  ? ClientHomePage.routeName
                  : CompanyPlaceholder.routeName
              : LanguageSelectionPage.routeName,
        );
      });
      super.initState();
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
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

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      print(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
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
                Text(KAppName,
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
