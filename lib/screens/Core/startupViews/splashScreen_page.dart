import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:techtime/Controllers/blocs/core/Authentication/authentication_bloc.dart';
import 'package:techtime/Helpers/APIUrls.dart';
import 'package:techtime/Helpers/enums.dart';

import '../../../main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _token;

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (message != null) {
        print(message);
      }
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
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
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
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        switch (state.status) {
          case AuthenticationStatus.authenticated:
            print("authenticated");
            return Timer(
                Duration(seconds: 3),
                () => Navigator.of(context)
                    .pushReplacementNamed("/languageSelection"));
            break;
          case AuthenticationStatus.unauthenticated:
            print("unauthenticated");

            return Timer(
                Duration(seconds: 3),
                () => Navigator.of(context)
                    .pushReplacementNamed("/languageSelection"));
            break;
          default:
            break;
        }
      },
      builder: (context, state) {
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
      },
    );
  }
}
