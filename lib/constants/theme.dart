import 'package:flutter/material.dart';

const Color darkYellow = Color(0xFFEC9F00);
const lightYellow = Color(0xFFF4B301);
const Color whiteColor = Color(0xFFF2F3F2);
const Color darkGrayColor = Color(0xFF3b4046);

LinearGradient themeGradient = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [
    lightYellow.withOpacity(0.5),
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
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(darkGrayColor),
      foregroundColor: MaterialStateProperty.all(whiteColor),
    )),
    textTheme: const TextTheme(
        headlineMedium: TextStyle(
            fontWeight: FontWeight.w900,
            color: darkGrayColor,
            fontFamily: 'Roboto',
            fontSize: 32),
        bodyMedium: TextStyle(
          fontSize: 16,
          color: darkGrayColor,
          fontFamily: "Roboto",
          fontWeight: FontWeight.w500,
        )),
    colorScheme: const ColorScheme(
      background: darkGrayColor,
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
