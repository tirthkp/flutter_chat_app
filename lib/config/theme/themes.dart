import 'package:flutter/material.dart';
import 'package:flutter_chat_app/config/colors.dart';

var lightTheme = ThemeData.light(
  useMaterial3: true,
).copyWith(
  iconTheme: const IconThemeData(color: lBackgroundColor),
  scaffoldBackgroundColor: lBackgroundColor,
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        fontSize: 20,
        color: lOnBackgroundColor,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
      ),
      backgroundColor: lContainerColor,
      iconTheme: IconThemeData(color: lOnContainerColor)),
  inputDecorationTheme: const InputDecorationTheme(
    fillColor: lBackgroundColor,
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(width: 0),
    ),
    hintStyle: TextStyle(
      fontSize: 12,
      color: lOnContainerColor,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
    ),
  ),
  colorScheme: const ColorScheme.dark(
    primary: lPrimaryColor,
    onPrimary: lContainerColor,
    surface: lBackgroundColor,
    onSurface: lOnBackgroundColor,
    primaryContainer: lContainerColor,
    onPrimaryContainer: lBackgroundColor,
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 32,
      color: lPrimaryColor,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w800,
    ),
    headlineMedium: TextStyle(
      fontSize: 30,
      color: lOnBackgroundColor,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: TextStyle(
      fontSize: 20,
      color: lOnBackgroundColor,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
    ),
    labelLarge: TextStyle(
      fontSize: 15,
      color: lOnContainerColor,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      color: lOnContainerColor,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(
      fontSize: 10,
      color: lOnContainerColor,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w300,
    ),
    bodyLarge: TextStyle(
      fontSize: 18,
      color: lOnBackgroundColor,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: TextStyle(
      fontSize: 15,
      color: lOnBackgroundColor,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
    ),
  ),
);
var darkTheme = ThemeData(useMaterial3: true).copyWith(
  iconTheme: const IconThemeData(color: dOnBackgroundColor),
  scaffoldBackgroundColor: dBackgroundColor,
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    backgroundColor: dContainerColor,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    hintStyle: TextStyle(
      fontSize: 12,
      color: dOnContainerColor,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
    ),
    fillColor: dBackgroundColor,
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(width: 0),
    ),
  ),
  colorScheme: const ColorScheme.dark(
    primary: dPrimaryColor,
    onPrimary: dOnBackgroundColor,
    surface: dBackgroundColor,
    onSurface: dOnBackgroundColor,
    primaryContainer: dContainerColor,
    onPrimaryContainer: dOnContainerColor,
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 32,
      color: dPrimaryColor,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w800,
    ),
    headlineMedium: TextStyle(
      fontSize: 30,
      color: dOnBackgroundColor,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: TextStyle(
      fontSize: 20,
      color: dOnBackgroundColor,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
    ),
    labelLarge: TextStyle(
      fontSize: 15,
      color: dOnContainerColor,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      color: dOnContainerColor,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(
      fontSize: 10,
      color: dOnContainerColor,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w300,
    ),
    bodyLarge: TextStyle(
      fontSize: 18,
      color: dOnBackgroundColor,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: TextStyle(
      fontSize: 15,
      color: dOnBackgroundColor,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
    ),
  ),
);
