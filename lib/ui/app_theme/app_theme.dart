import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram_clone/business_logic/utils/constants/constants.dart';
import 'package:sizer/sizer.dart';

final _lightThemeData = ThemeData.light();
final _darkThemeData = ThemeData.dark();

final primaryMaterialTheme = _lightThemeData.copyWith(
    colorScheme: ColorScheme(
      primary: Color(0xff8a4cff),
      primaryContainer: Color(0xff09a5fd),
      secondary: Color(0xffbfbade),
      secondaryVariant: Colors.white,
      background: Color(0xffe5e6ed),
      brightness: Brightness.light,
      error: Colors.red,
      onBackground: Color(0xffe5e6ed),
      onError: Colors.red,
      onSecondary: Color(0xffffffff),
      onPrimary: Colors.black,
      onSurface: Colors.white,
      secondaryContainer: Color(0xffB795E2),
      surface:Colors.grey,
    ),
    textTheme: _lightThemeData.textTheme.copyWith(
      bodyText1: TextStyle(
          fontSize: 13.sp,

          fontWeight: FontWeight.w400,
          fontFamily: Constants.fontFamily),
      bodyText2: TextStyle(
          fontSize: 13.sp,
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontFamily: Constants.fontFamily),
          headline1: GoogleFonts.poppins(textStyle:TextStyle(fontWeight: FontWeight.bold)),
      headline6: TextStyle(fontSize: 18.0, fontFamily: Constants.fontFamily),
      button: TextStyle(fontSize: 16.0, letterSpacing: 1),
      subtitle2: TextStyle(fontFamily: Constants.fontFamily),
      headline3: TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.black,
          fontFamily: Constants.fontFamily),
    ));
final darkMaterialTheme = _darkThemeData.copyWith(
  colorScheme: ColorScheme(
    primary: Colors.white,
    primaryVariant: Colors.white,
    secondary: Color.fromRGBO(0, 149, 246, 1),
    secondaryVariant: Colors.white,
    background: Colors.white,
    brightness: Brightness.light,
    error: Colors.red,
    onBackground: Colors.white,
    onError: Colors.red,
    onSecondary: Colors.white,
    onPrimary: Colors.black,
    onSurface: Colors.white,
    surface: Color.fromRGBO(0, 149, 246, 1),
  ),
  textTheme: _darkThemeData.textTheme.apply(
    fontFamily: 'Open Sans',
  ),
);

final primaryCupertinoTheme = CupertinoThemeData(
  primaryColor: CupertinoDynamicColor.withBrightness(
    color: Colors.purple,
    darkColor: Colors.cyan,
  ),
);

