import 'package:flutter/material.dart';

const Color darkYellow = Color(0xFFEC9F00);
const lightYellow = Color(0xFFF4B301);
const veryLightYellow = Color(0xFFFED154);
const Color whiteColor = Color(0xFFF2F3F2);
const Color darkGrayColor = Color(0xFF3b4046);
const Color lightGrayColor = Color(0xFFE5E5E5);

LinearGradient themeGradient = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [
    lightYellow.withOpacity(0.8),
    darkYellow,
  ],
);

ThemeData lightThemeData = ThemeData(
    backgroundColor: whiteColor,
    primaryColor: darkYellow,
    iconTheme: const IconThemeData(color: darkGrayColor, size: 30),
    brightness: Brightness.light,
    primaryColorDark: darkGrayColor,
    primaryColorLight: darkGrayColor,
    scaffoldBackgroundColor: whiteColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(darkGrayColor),
            foregroundColor: MaterialStateProperty.all(whiteColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            )))),
    textTheme: const TextTheme(
        headline3: TextStyle(
            fontWeight: FontWeight.w600,
            color: darkGrayColor,
            fontFamily: 'Roboto',
            fontSize: 20),
        headline2: TextStyle(
            fontWeight: FontWeight.w900,
            color: darkGrayColor,
            fontFamily: 'Roboto',
            fontSize: 32),
        bodyText2: TextStyle(
          fontSize: 16,
          color: darkGrayColor,
          fontFamily: "Roboto",
          fontWeight: FontWeight.w500,
        ),
        bodyText1: TextStyle(
          fontSize: 15,
          color: darkGrayColor,
          fontFamily: "Roboto",
          fontWeight: FontWeight.w300,
        )),
    colorScheme: const ColorScheme(
      background: lightGrayColor,
      onSurface: lightYellow,
      onPrimary: darkGrayColor,
      secondary: lightYellow,
      primary: darkGrayColor,
      surface: darkGrayColor,
      error: whiteColor,
      onBackground: darkGrayColor,
      onError: whiteColor,
      brightness: Brightness.light,
      onSecondary: darkGrayColor,
    ));
