import 'package:flutter/material.dart';
import 'package:wc_project/shared/constants_shared.dart';

class SharedTheme {
  static double screenWidth = 0.0, screenHeight = 0.0;
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    primaryColor: Colors.white,
    brightness: Brightness.light,
    textTheme: TextTheme(
      displaySmall: TextStyle(
        fontSize: screenHeight * SharedConstants.generalPadding * 0.85,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      displayMedium: TextStyle(
        fontSize: screenHeight * SharedConstants.generalPadding,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      displayLarge: TextStyle(
        fontSize: screenHeight * SharedConstants.generalPadding * 1.15,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
      size: screenHeight * SharedConstants.generalPadding * 2,
    ),
  );
  static ThemeData get themeGet => lightTheme;
}
