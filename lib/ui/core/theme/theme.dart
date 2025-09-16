import 'package:flutter/material.dart';

class StudieTheme {
  // https://color.adobe.com/pt/explore

  static Color primaryColor = Color(0xFF002333);
  static Color whiteColor = Color(0xFFFFFFFF);
  static Color whiteSmoke = Color(0xFFDEEFE7);
  static Color secondaryColor = Color(0xFF159A9C);
  static Color terciaryColor = Color(0xFFB4BEC9);

  static TextTheme textTheme = TextTheme(
    bodyLarge: TextStyle(
      color: primaryColor,
      fontSize: 28,
      fontWeight: FontWeight.w600,
    ),
    bodyMedium: TextStyle(
      color: primaryColor,
      fontSize: 22,
      fontWeight: FontWeight.w500,
    ),
    bodySmall: TextStyle(
      color: primaryColor,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    displayLarge: TextStyle(
      fontFamily: "Libertinus_discursive",
      fontSize: 28,
      fontWeight: FontWeight.w500,
    ),
    displayMedium: TextStyle(
      fontFamily: "Libertinus_discursive",
      fontSize: 22,
      fontWeight: FontWeight.w400,
    ),
    displaySmall: TextStyle(
      fontFamily: "Libertinus_discursive",
      fontSize: 16,
      fontWeight: FontWeight.w300,
    ),
    titleSmall: TextStyle(
      color: whiteSmoke,
      fontSize: 19,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      color: whiteSmoke,
      fontSize: 25,
      fontWeight: FontWeight.w500,
    ),
    titleLarge: TextStyle(
      color: whiteSmoke,
      fontSize: 32,
      fontWeight: FontWeight.w600,
    ),
  );

  static String secondaryFont = "Libertinus_discursive";

  static ThemeData theme = ThemeData(
    colorSchemeSeed: primaryColor,
    fontFamily: "Libertinus",
    useMaterial3: true,
    textTheme: textTheme,
  );
}
