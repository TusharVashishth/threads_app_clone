import 'package:flutter/material.dart';

final ThemeData theme = ThemeData(
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      elevation: 0.0,
      surfaceTintColor: Colors.black,
    ),
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      brightness: Brightness.dark,
      background: Colors.black,
      onBackground: Colors.white,
      surfaceTint: Colors.black12,
      primary: Colors.white,
      onPrimary: Colors.black,
    ),
    navigationBarTheme: const NavigationBarThemeData(
      height: 55,
      indicatorColor: Colors.transparent,
      elevation: 5.0,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      backgroundColor: Colors.black,
      iconTheme: MaterialStatePropertyAll<IconThemeData>(
        IconThemeData(
          color: Colors.white,
          size: 30,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        foregroundColor: MaterialStateProperty.all(Colors.black),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: const BorderSide(color: Colors.transparent),
        ),
      ),
      backgroundColor:
          MaterialStateProperty.all<Color>(const Color(0xff242424)),
      minimumSize: MaterialStateProperty.all(Size.zero),
      padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      ),
    )));
