import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';


final BorderRadius radius = BorderRadius.circular(6.0);

class AppTheme {
  static Color backgroundColor = Color(0xff181b45);

//  Color(0xff1d1f24);
  static Color mainColor = Color(0xff181b45);

//Color mainColor = Color(0xffea4c89);
//Color mainColor = Color(0xff0de8d1);
  static Color secondaryColor = Color(0xffedc314);
  static Color disabledTextColor = Color(0xff6b717e);
  static Color lightTextColor = Color(0xff4cffffff);
  static Color transparentColor = Colors.transparent;
  static Color darkColor = Color(0xff151619);
  static Color fbColor = Color(0xff3c5a9a);
  static Color videoCall = Colors.red;

  final ThemeData appTheme = ThemeData.light().copyWith(
    primaryColorLight:Color(0xFF181b45),
    primaryColorDark: Colors.white,
      colorScheme: ColorScheme(
        primary: Color(0xFF181b45),
        primaryVariant: Colors.white,
        secondary: Color.fromRGBO(0, 149, 246, 1),
        secondaryVariant: Colors.grey,
        surface: Color(0xFFE5E3DC),
        background: Color.fromRGBO(0, 0, 0, 1),
        error: Colors.redAccent,
        onPrimary: mainColor,
        onSecondary: Color(0xffedc314),
        onBackground: Colors.white,
        onError: Colors.redAccent,
        onSurface: Color(0xFFE5E3DC),
        brightness: Brightness.light,
      ),
   
      scaffoldBackgroundColor: backgroundColor,
      primaryColor: mainColor,
      accentColor: mainColor,

      ///appBar theme
      appBarTheme: AppBarTheme(
        color: transparentColor,
        elevation: 0.0,
      ),

      ///text theme
      textTheme: GoogleFonts.openSansTextTheme().copyWith(
        subtitle1: TextStyle(color: disabledTextColor),
        caption: TextStyle(color: disabledTextColor),
        bodyText1: TextStyle(fontSize: 13.sp),
        headline6: TextStyle(fontSize: 18.0),
        button: TextStyle(fontSize: 16.0, letterSpacing: 1),
        subtitle2: TextStyle(),
        bodyText2: TextStyle(),
        headline3: TextStyle(fontWeight: FontWeight.w800, color: Colors.black),
      ));
      
} 

/// NAME         SIZE  WEIGHT  SPACING
/// headline1    96.0  light   -1.5
/// headline2    60.0  light   -0.5
/// headline3    48.0  regular  0.0
/// headline4    34.0  regular  0.25
/// headline5    24.0  regular  0.0
/// headline6    20.0  medium   0.15
/// subtitle1    16.0  regular  0.15
/// subtitle2    14.0  medium   0.1
/// body1        16.0  regular  0.5   (bodyText1)
/// body2        14.0  regular  0.25  (bodyText2)
/// button       14.0  medium   1.25
/// caption      12.0  regular  0.4
/// overline     10.0  regular  1.5
