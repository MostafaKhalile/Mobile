import 'package:flutter/material.dart';
import 'package:techtime/Helpers/colors.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
    brightness: Brightness.light,
    primaryColor: KPrimaryColor,
    accentColor: Colors.black,
    iconTheme: iconThemeData(),
    tabBarTheme: TabBarTheme(
        unselectedLabelStyle: textTheme().subtitle1.apply(fontFamily: 'cocon'),
        labelColor: Colors.black,
        labelStyle: textTheme().subtitle1.apply(fontFamily: 'cocon')),
    primaryColorDark: Colors.white,
    bottomAppBarColor: Colors.black,
    // ignore: deprecated_member_use
    cursorColor: Colors.black,
    scaffoldBackgroundColor: KLightScaffoldColor,
    inputDecorationTheme: inputDecorationTheme(),
    textTheme: textTheme().apply(
      fontFamily: 'cocon',
    ),
    appBarTheme: appBarTheme(),
    buttonTheme: buttonThemeData());

ButtonThemeData buttonThemeData() {
  return ButtonThemeData(
    height: 50,
    buttonColor: Colors.black,
    shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
        side: BorderSide(color: KPrimaryColor, width: 2)),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
      brightness: Brightness.light,
      color: Color(0xffFFDC00),
      centerTitle: true,
      elevation: 8,
      shadowColor: Colors.grey[300],
      iconTheme: IconThemeData(color: Colors.black),
      actionsIconTheme: IconThemeData(color: Colors.black));
}

TextTheme textTheme() {
  return TextTheme(
    headline1: TextStyle(color: Colors.black),
    headline3: TextStyle(color: Colors.black),
    headline4: TextStyle(color: Colors.black),
    headline5: TextStyle(color: Colors.black),
    headline6: TextStyle(color: Colors.black),
    subtitle1: TextStyle(color: Colors.black),
    subtitle2: TextStyle(color: Colors.black),
    caption: TextStyle(color: Colors.black),
    button: TextStyle(
        color: KPrimaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 18,
        wordSpacing: 1.5,
        letterSpacing: 1.5),
  );
}

InputDecorationTheme inputDecorationTheme() {
  return InputDecorationTheme(
      fillColor: Colors.white,
      contentPadding: EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
      border: OutlineInputBorder(
          borderSide: BorderSide(width: 3),
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 3),
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 3),
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 3),
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      hintStyle: TextStyle(color: Colors.black));
}

IconThemeData iconThemeData() => IconThemeData(color: Colors.black, size: 18);
