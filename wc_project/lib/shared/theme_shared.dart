import 'package:flutter/material.dart';

import 'constant_shared.dart';

class SharedTheme {
  final bool isDarkModeTheme;
  double width, height;

  SharedTheme({
    required this.isDarkModeTheme,
    required this.width,
    required this.height,
  });

  static ThemeData getTextTheme(
      bool isDarkModeTheme, double width, double height) {
    return ThemeData(
      textTheme: TextTheme(
        displaySmall: TextStyle(
          fontSize: height > width
              ? height * SharedConstants.generalSize * 1.15
              : width * SharedConstants.generalSize * 1.15,
          fontWeight: FontWeight.w400,
          color: Colors.grey,
        ),
        displayMedium: TextStyle(
          fontSize: height > width
              ? height * SharedConstants.generalSize * 1.4
              : width * SharedConstants.generalSize * 1.4,
          fontWeight: FontWeight.w400,
          color: isDarkModeTheme == true ? Colors.white : Colors.black,
        ),
        displayLarge: TextStyle(
          fontSize: height > width
              ? height * SharedConstants.generalSize * 1.65
              : width * SharedConstants.generalSize * 1.65,
          fontWeight: FontWeight.w400,
          color: isDarkModeTheme == true ? Colors.white : Colors.black,
        ),
        bodySmall: TextStyle(
          fontSize: height > width
              ? height * SharedConstants.generalSize * 0.85
              : width * SharedConstants.generalSize * 0.85,
          fontWeight: FontWeight.w400,
          color: Colors.grey,
        ),
        bodyMedium: TextStyle(
          fontSize: height > width
              ? height * SharedConstants.generalSize
              : width * SharedConstants.generalSize,
          fontWeight: FontWeight.w400,
          color: isDarkModeTheme == true ? Colors.white : Colors.black,
        ),
        bodyLarge: TextStyle(
          fontSize: height > width
              ? height * SharedConstants.generalSize * 1.15
              : width * SharedConstants.generalSize * 1.15,
          fontWeight: FontWeight.w400,
          color: isDarkModeTheme == true ? Colors.white : Colors.black,
        ),
      ),
      iconTheme: IconThemeData(
        size: height * SharedConstants.generalSize * 2,
        color: isDarkModeTheme == true ? Colors.white : Colors.black,
      ),
    );
  }

  static ThemeData darkTheme(
      bool isDarkModeTheme, double width, double height) {
    return ThemeData(
      colorSchemeSeed: const Color.fromARGB(255, 61, 219, 153),
      brightness: Brightness.dark,
      textTheme: getTextTheme(isDarkModeTheme, width, height).textTheme,
    );
  }

  static ThemeData lightTheme(
      bool isDarkModeTheme, double width, double height) {
    return ThemeData(
      colorSchemeSeed: const Color.fromARGB(255, 61, 219, 153),
      brightness: Brightness.light,
      textTheme: getTextTheme(isDarkModeTheme, width, height).textTheme,
    );
  }
}
