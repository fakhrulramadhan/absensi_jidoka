import 'package:flutter/material.dart';

//buat konstanta utk warna tema (tinggal ganti tema),buat color palette nya
const appRed = Color.fromARGB(255, 114, 9, 9);
const appPink = Color.fromARGB(255, 245, 70, 210);
const appBlack = Colors.black;
const appGreen = Color.fromARGB(255, 109, 226, 117);
const appYellow = Color.fromARGB(255, 252, 255, 79);
const appWhite = Color.fromARGB(255, 255, 255, 255);
const appBlue = Color.fromARGB(255, 73, 213, 255);

ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    //text theme utk widget text
    //appbartheme utk widget appbar
    //elevatedbutton theme utk widget elevatedbutton, default wrn merah
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: appWhite),
      bodyMedium: TextStyle(color: appWhite),
      displayLarge: TextStyle(color: appWhite),

      //displayLarge: TextStyle(color: Colors.blue)
    ),
    appBarTheme: const AppBarTheme(color: appBlack),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(backgroundColor: appPink)));

//tampilan tema aplikasi (light)
ThemeData light = ThemeData(
    brightness: Brightness.light,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: appWhite),
      bodyMedium: TextStyle(color: appBlue),
      displayLarge: TextStyle(color: Colors.white),
      //displayLarge: TextStyle(color: Colors.blue)
    ),
    appBarTheme: const AppBarTheme(color: appBlue),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(backgroundColor: appBlue)));
