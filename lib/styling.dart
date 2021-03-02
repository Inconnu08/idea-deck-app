import 'package:flutter/material.dart';
import './size_config.dart';

import 'constants.dart';

class AppTheme {
  AppTheme._();

  static const Color appBackgroundColor = Color(0xFFFFF7EC);
  static const Color topBarBackgroundColor = Color(0xFFFFD974);
  static const Color selectedTabBackgroundColor = Color(0xFFFFC442);
  static const Color unSelectedTabBackgroundColor = Color(0xFFFFFFFC);
  static const Color subTitleTextColor = Color(0xFF9F988F);

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppTheme.appBackgroundColor,
    brightness: Brightness.light,
    textTheme: lightTextTheme,
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    brightness: Brightness.dark,
    textTheme: darkTextTheme,
  );

  static final TextTheme lightTextTheme = TextTheme(
    headline6: _headLine6Light,
    headline5: _headLine5Light,
    headline1: _headLine1Light,
    subtitle2: _subTitleLight,
    button: _buttonLight,
    headline4: _greetingLight,
    headline3: _searchLight,
    bodyText2: _selectedTabLight,
    bodyText1: _unSelectedTabLight,
  );

  static final TextTheme darkTextTheme = TextTheme(
    headline6: _headLine6Dark,
    // headline5: _headLine5Dark,
    // headline1: _headLine1Dark,
    subtitle2: _subTitleDark,
    button: _buttonDark,
    headline4: _greetingDark,
    headline3: _searchDark,
    bodyText2: _selectedTabDark,
    bodyText1: _unSelectedTabDark,
  );

  static final TextStyle _titleLight = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 3 * SizeConfig.textMultiplier,
  );

  static final TextStyle _headLine6Light = TextStyle(
    fontWeight: FontWeight.w100,
    color: lightText,
    fontSize: 3 * SizeConfig.textMultiplier,
  );

  static final TextStyle _headLine1Light = TextStyle(
      fontSize: 5.6 * SizeConfig.textMultiplier,
      fontWeight: FontWeight.w900,
      color: Colors.white);

  static final TextStyle _headLine5Light = TextStyle(
    fontWeight: FontWeight.w100,
    color: lighterText,
    fontSize: 2.5 * SizeConfig.textMultiplier,
  );

  static final TextStyle _subTitleLight = TextStyle(
      fontSize: 3.5 * SizeConfig.textMultiplier,
      fontWeight: FontWeight.w900,
      color: kPrimaryColor);

  static final TextStyle _buttonLight = TextStyle(
    color: Colors.black,
    fontSize: 2.5 * SizeConfig.textMultiplier,
  );

  static final TextStyle _greetingLight = TextStyle(
    color: Colors.black,
    fontSize: 2.0 * SizeConfig.textMultiplier,
  );

  static final TextStyle _searchLight = TextStyle(
    color: Colors.black,
    fontSize: 2.3 * SizeConfig.textMultiplier,
  );

  static final TextStyle _selectedTabLight = TextStyle(
    color: kPrimaryColor,
    fontWeight: FontWeight.w100,
    fontSize: 2 * SizeConfig.textMultiplier,
  );

  static final TextStyle _unSelectedTabLight = TextStyle(
    color: kTextColor,
    fontSize: 1.9 * SizeConfig.textMultiplier,
  );

  static final TextStyle _titleDark = _titleLight.copyWith(color: Colors.white);

  static final TextStyle _subTitleDark =
      _subTitleLight.copyWith(color: Colors.white70);

  static final TextStyle _buttonDark =
      _buttonLight.copyWith(color: Colors.black);

  static final TextStyle _greetingDark =
      _greetingLight.copyWith(color: Colors.black);

  static final TextStyle _searchDark =
      _searchDark.copyWith(color: Colors.black);

  static final TextStyle _selectedTabDark =
      _selectedTabDark.copyWith(color: Colors.white);

  static final TextStyle _unSelectedTabDark =
      _selectedTabDark.copyWith(color: Colors.white70);

  static final TextStyle _headLine6Dark =
      _subTitleLight.copyWith(color: kPrimaryColor);
}
