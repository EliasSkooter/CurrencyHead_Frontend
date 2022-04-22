// ignore_for_file: constant_identifier_names, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';

import 'common.dart';

/// primary and stroke (accent ?) color of the app *****************************
const PRIMARY_COLOR = Color(0xffd4af37), STROKE_COLOR = Color(0xffFFFFFF);

/// ****************************************************************************

/// and a preset for the primary color of the app
MaterialColor primaryColorSwatch = createMaterialColor(PRIMARY_COLOR);

/// default theme called in main.dart's MyApp() ********************************
ThemeData defaultTheme(context) => ThemeData(
      primarySwatch: createMaterialColor(primaryColorSwatch),
      primaryColor: PRIMARY_COLOR,
    );

/// ****************************************************************************

/// function that creates color swatches from any color
/// credit: https://medium.com/@filipvk/creating-a-custom-color-swatch-in-flutter-554bcdcb27f3
MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}

/// ****************************************************************************

/// presetTextThemes used for headings, body texts, and others *****************
/// NOTE: the fontSize takes the longest side of the screen (so width on wide desktop
/// screens and height on smaller phone screens) and divides them by the ratio
/// 1080 / defaultPixelSize (screenHeight:fontPixelSize ratio) to get the right
/// consistent font size accross all screens
TextTheme presetTextThemes(context) {
  double fontSizeMultiplier = isLargeScreen(context) ? 1 : 1.3;

  return TextTheme(
    headline1: TextStyle(
      fontSize:
          (fontSizeMultiplier * MediaQuery.of(context).size.shortestSide) /
              (1080 / 64.0),
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headline2: TextStyle(
      fontSize:
          (fontSizeMultiplier * MediaQuery.of(context).size.shortestSide) /
              (1080 / 56.0),
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headline3: TextStyle(
      fontSize:
          (fontSizeMultiplier * MediaQuery.of(context).size.shortestSide) /
              (1080 / 48.0),
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headline4: TextStyle(
      fontSize:
          (fontSizeMultiplier * MediaQuery.of(context).size.shortestSide) /
              (1080 / 40.0),
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headline5: TextStyle(
      fontSize:
          (fontSizeMultiplier * MediaQuery.of(context).size.shortestSide) /
              (1080 / 32.0),
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headline6: TextStyle(
      fontSize:
          (fontSizeMultiplier * MediaQuery.of(context).size.shortestSide) /
              (1080 / 26.0),
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    bodyText1: TextStyle(
      fontSize:
          (fontSizeMultiplier * MediaQuery.of(context).size.shortestSide) /
              (1080 / 18.0),
    ),
    bodyText2: TextStyle(
      fontSize:
          (fontSizeMultiplier * MediaQuery.of(context).size.shortestSide) /
              (1080 / 24.0),
      fontWeight: FontWeight.w100,
      color: Colors.grey,
    ),
  );
}

/// ****************************************************************************
