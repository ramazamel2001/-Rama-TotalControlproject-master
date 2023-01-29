import 'package:flutter/material.dart';

import 'package:pro1/Theme/app_themes.dart';

Themes _themes = Themes();

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: background4,
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(
      color: fontColor4,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: MaterialStateProperty.all<double>(10),
      backgroundColor: MaterialStateProperty.all<Color>(
        background3,
      ),
      minimumSize: MaterialStateProperty.all<Size>(
        const Size(200, 50),
      ),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ),
  ),
  canvasColor: background3,
  drawerTheme: DrawerThemeData(
    backgroundColor: background4,
  ),
  dialogBackgroundColor: background3,
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: background7,
  ),
  shadowColor: fontColor3,
  cardTheme: CardTheme(
    shadowColor: Colors.transparent,
    color: background4,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    splashColor: Colors.transparent,
    elevation: 0,
  ),
  splashColor: Colors.transparent,
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  splashColor: Colors.transparent,
  scaffoldBackgroundColor: background1,
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(
      color: fontColor4,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: MaterialStateProperty.all<double>(20),
      shadowColor: MaterialStateProperty.all<Color>(
        background2,
      ),
      backgroundColor: MaterialStateProperty.all<Color>(
        background2,
      ),
      minimumSize: MaterialStateProperty.all<Size>(
        const Size(200, 50),
      ),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ),
  ),
  canvasColor: background2,
  drawerTheme: DrawerThemeData(
    backgroundColor: background1,
  ),
  dialogBackgroundColor: background1,
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: background1,
  ),
  shadowColor: fontColor1,
  cardTheme: CardTheme(
    shadowColor: Colors.transparent,
    color: background3,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    elevation: 0,
    splashColor: Colors.transparent,
  ),
);

/**
 * NOTE: those are the widgets used in our app
 *
 * TextFormField
 * ElevatedButton
 * TextButton
 * Card
 * Container
 * AppBar
 * Drawer
 * Text
 * InkWell
 * ListTile
 * Icon
 * IconButton
 * Chart
 * GNav
 * Search
 * Material
 *
 */
