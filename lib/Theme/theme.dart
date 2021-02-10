import 'package:flutter/material.dart';
import 'package:techtime/Theme/app_consts.dart';

ThemeData darkTheme = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    primaryColor: KPrimaryColor,
    accentColor: Color(0xff40bf7a),
    scaffoldBackgroundColor: Colors.black,
    textTheme: TextTheme(
        headline1: TextStyle(color: Colors.white),
        headline6: TextStyle(color: Color(0xff40bf7a)),
        subtitle2: TextStyle(color: Colors.white),
        subtitle1: TextStyle(color: Color(0xff40bf7a))),
    appBarTheme: AppBarTheme(color: Color(0xffFFDC00)),
    buttonTheme: ButtonThemeData(
        height: 50,
        buttonColor: Colors.black,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        textTheme: ButtonTextTheme.primary));

ThemeData lightTheme = ThemeData.light().copyWith(
    brightness: Brightness.light,
    primaryColor: Color(0xffFFDC00),
    accentColor: Color(0xff40bf7a),
    textTheme: TextTheme(
        headline1: TextStyle(color: Colors.black),
        headline6: TextStyle(color: Colors.black54),
        subtitle2: TextStyle(color: Colors.grey),
        subtitle1: TextStyle(color: Colors.white)),
    appBarTheme: AppBarTheme(
        color: Color(0xffFFDC00),
        actionsIconTheme: IconThemeData(color: Colors.white)),
    buttonTheme: ButtonThemeData(
        height: 50,
        buttonColor: Colors.yellow,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        textTheme: ButtonTextTheme.primary));
