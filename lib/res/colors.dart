import 'package:flutter/material.dart';
import 'package:simple_flutter_app/res/misc.dart';

class AppColors {
  static const Color colorPrimary = Color(0xFF005B82);
  static const Color colorSecondary = Color(0xFF005B82);
  static const Color colorAccent = Color(0xFFF1F7FA);
  static const Color colorPrimaryLight = Color(0x33005B82);
  static const Color colorSecondaryLight = Color(0xFF119CD4);

  static const Color colorBorder = Color(0x806B91A0);
  static const Color colorBorderGrey = Color(0x47707070);
  static const Color colorBorderGraph = Color(0xFF799BA9);
  static const Color colorBackground = Color(0xFFF0F3F9);
  static const Color colorShadow = Color(0x26000000);

  static const Color textPrimary = Color(0xFF002743);
  static const Color textPrimaryLight = Color(0xB2002743);
  static const Color textSecondary = Color(0xFF707070);
  static const Color textAccent = Color(0xFF6B91A0);
  static const Color textDanger = Color(0xFFE57373);

  static const Color transparent = Color(0x00000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey = Color(0xFFEEEEEE);
  static const Color red = Color(0xFFE35454);
  static const Color yellow = Color(0xFFffb700);
  static const Color green = Color(0xFF028965);
  static const Color blue = Color(0xFF179BD4);
  // static const Color windowBackground = const Color(0xFFF8F8F8);
  static const Color windowBackground = colorBackground;

  static const Color faintIconColor = Color(0xFFB1BACA);

  static const List<Color> randomColors = [
    Color(0xFFA97829),
    Color(0xFFA34A31),
    Color(0xFFAA8439),
    Color(0xFF80271D),
    Color(0xFF228C86),
    Color(0xFF016591),
    Color(0xFFfa6400),
    Color(0xFFffb700),
    Color(0xFF1cc6cc),
    Color(0xFFC75146),
    Color(0xFF7BDFF2),
    Color(0xFFFFAE03),
    Color(0xFFFFD275),
    Color(0xFFE35454),
    colorPrimary,
    colorSecondary,
    colorPrimaryLight,
    colorSecondaryLight,
    red,
    blue,
  ];

  static const int _primaryValue = 0xFF005B82;
  static const int _secondaryValue = 0xFF0C316B;
  static Color primary = const Color(_primaryValue);
  static Color secondary = const Color(_secondaryValue);
  static Color background = const Color(0xFFF0F2F1);

  static MaterialColor primarySwatch = MaterialColor(_primaryValue, {
    50: const Color(_primaryValue).lighten(.5),
    100: const Color(_primaryValue).lighten(.4),
    200: const Color(_primaryValue).lighten(.3),
    300: const Color(_primaryValue).lighten(.2),
    400: const Color(_primaryValue).lighten(.1),
    500: const Color(_primaryValue),
    600: const Color(_primaryValue).darken(.04),
    700: const Color(_primaryValue).darken(.08),
    800: const Color(_primaryValue).darken(.12),
    900: const Color(_primaryValue).darken(.16),
  });
  
  static MaterialColor secondarySwatch = MaterialColor(_secondaryValue, {
    50: const Color(_secondaryValue).lighten(.5),
    100: const Color(_secondaryValue).lighten(.4),
    200: const Color(_secondaryValue).lighten(.3),
    300: const Color(_secondaryValue).lighten(.2),
    400: const Color(_secondaryValue).lighten(.1),
    500: const Color(_secondaryValue),
    600: const Color(_secondaryValue).darken(.04),
    700: const Color(_secondaryValue).darken(.08),
    800: const Color(_secondaryValue).darken(.12),
    900: const Color(_secondaryValue).darken(.16),
  });
}
