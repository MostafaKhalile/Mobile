import 'package:flutter/material.dart';
import 'package:techtime/Helpers/app_colors.dart';

ThemeData darkTheme = ThemeData.dark().copyWith(
    // applyElevationOverlayColor: true,
    brightness: Brightness.dark,
    accentColor: Colors.white,
    primaryColor: AppColors.primaryColor,
    shadowColor: const Color(0xFF303030),
    primaryColorDark: Colors.black,
    bottomAppBarColor: Colors.white,
    iconTheme: iconThemeData(),
    tabBarTheme: TabBarTheme(
        unselectedLabelStyle: textTheme().subtitle1!.apply(fontFamily: 'cocon'),
        labelColor: Colors.white,
        labelStyle: textTheme().subtitle1!.apply(fontFamily: 'cocon')),
    // ignore: deprecated_member_use
    cursorColor: AppColors.primaryColor,
    scaffoldBackgroundColor: Colors.black,
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
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
      brightness: Brightness.dark,
      // shadowColor: Colors.white,
      centerTitle: true,
      elevation: 8,
      iconTheme: IconThemeData(color: Colors.white),
      actionsIconTheme: IconThemeData(color: Colors.white));
}

TextTheme textTheme() {
  return const TextTheme(
    headline1: TextStyle(color: Colors.white),
    headline3: TextStyle(color: Colors.white),
    headline4: TextStyle(color: Colors.white),
    headline5: TextStyle(color: Colors.white),
    headline6: TextStyle(color: Colors.white),
    subtitle1: TextStyle(color: Colors.white),
    subtitle2: TextStyle(color: Colors.white),
    caption: TextStyle(color: Colors.white),
    button: TextStyle(
      color: AppColors.primaryColor,
      fontWeight: FontWeight.bold,
      fontSize: 18,
      wordSpacing: 1.5,
      letterSpacing: 1.5,
    ),
  );
}

InputDecorationTheme inputDecorationTheme() {
  return const InputDecorationTheme(
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

IconThemeData iconThemeData() =>
    const IconThemeData(color: AppColors.primaryColor, size: 18);
