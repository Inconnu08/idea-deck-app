import 'package:flutter/material.dart';

import './styling.dart';
import 'constants.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "NotoSans",
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    accentColor: kAccent,
    cursorColor: buttonColor,
    focusColor: kPrimaryColor,
  );
}

InputDecorationTheme inputDecorationTheme() {
  UnderlineInputBorder underlineInputBorder = UnderlineInputBorder(
    borderSide: BorderSide(color: buttonColor),
  );

  return InputDecorationTheme(
    contentPadding: EdgeInsets.only(top: 42, bottom: 20),
    // enabledBorder: outlineInputBorder,
    focusedBorder: underlineInputBorder,
    // border: outlineInputBorder,
    labelStyle: TextStyle(color: kPrimaryColor),
  );
}

TextTheme textTheme() {
  return AppTheme.lightTextTheme;
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: Colors.white,
    elevation: 0,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.black),
    textTheme: TextTheme(
      headline6: TextStyle(color: Color(0XFF7fad39), fontSize: 18),
    ),
  );
}

final ButtonStyle outlineButtonStyle = OutlinedButton.styleFrom(
  primary: kPrimaryColor,
  minimumSize: Size(88, 38),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
);
