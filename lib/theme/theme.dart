import 'package:flutter/material.dart';
import 'package:share_meal/constants/constans.dart';

ColorScheme myScheme =
    ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 49, 71, 56));
ColorScheme mySchemedark =
    ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 156, 206, 171));

final lightTheme = ThemeData().copyWith(
    brightness: Brightness.light,
    primaryColor: green, // Example primary color
    backgroundColor: white,
    selectedRowColor: black,
    primaryColorDark: grey,
    cardColor: lightgrey,
    primaryColorLight: lightgrey,
    colorScheme:
        ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 49, 71, 56)),
    useMaterial3: true,
    textTheme: TextTheme().copyWith(
      bodyMedium: TextStyle(fontFamily: 'Cairo', fontSize: 20, color: black),
    ),
    appBarTheme: AppBarTheme(
      // backgroundColor: white,
      titleTextStyle:
          TextStyle(color: black, fontFamily: 'Cairo', fontSize: 20),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom().copyWith(
            backgroundColor: MaterialStateProperty.all(
              myScheme.primary,
            ),
            foregroundColor: MaterialStateProperty.all(
              myScheme.onPrimary,
            ),
            shape: MaterialStatePropertyAll(ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: myScheme.onPrimary, width: 1))),
            padding: MaterialStatePropertyAll(
                EdgeInsets.symmetric(vertical: 10, horizontal: 24)),
            fixedSize: MaterialStatePropertyAll(
              Size.fromWidth(330),
            ))));

final darkTheme = ThemeData().copyWith(
    brightness: Brightness.light,
    primaryColor: green, // Example primary color
    backgroundColor: black,
    selectedRowColor: white,
    primaryColorDark: grey,
    cardColor: blacgrey,
    colorScheme:
        ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 49, 71, 56)),
    useMaterial3: true,
    textTheme: TextTheme().copyWith(
      bodyMedium: TextStyle(fontFamily: 'Cairo', fontSize: 20, color: white),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: black,
      titleTextStyle:
          TextStyle(color: white, fontFamily: 'Cairo', fontSize: 20),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom().copyWith(
            backgroundColor: MaterialStateProperty.all(
              myScheme.primary,
            ),
            foregroundColor: MaterialStateProperty.all(
              myScheme.onPrimary,
            ),
            shape: MaterialStatePropertyAll(ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: myScheme.onPrimary, width: 1))),
            padding: MaterialStatePropertyAll(
                EdgeInsets.symmetric(vertical: 10, horizontal: 24)),
            fixedSize: MaterialStatePropertyAll(
              Size.fromWidth(330),
            ))));
