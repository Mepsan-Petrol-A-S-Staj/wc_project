import 'package:flutter/material.dart';

import 'constant_shared.dart';

class SharedTheme {
  final bool isDarkModeTheme;
  final double width, height;

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
              ? height * SharedConstants.generalPadding * 1
              : width * SharedConstants.generalPadding * 1,
          fontWeight: FontWeight.w400,
          color: Colors.grey,
        ),
        displayMedium: TextStyle(
          fontSize: height > width
              ? height * SharedConstants.generalPadding * 1.25
              : width * SharedConstants.generalPadding * 1.25,
          fontWeight: FontWeight.w400,
          color: isDarkModeTheme == true ? Colors.white : Colors.black,
        ),
        displayLarge: TextStyle(
          fontSize: height > width
              ? height * SharedConstants.generalPadding * 1.5
              : width * SharedConstants.generalPadding * 1.5,
          fontWeight: FontWeight.w400,
          color: isDarkModeTheme == true ? Colors.white : Colors.black,
        ),
        bodySmall: TextStyle(
          fontSize: height > width
              ? height * SharedConstants.generalPadding * 0.6
              : width * SharedConstants.generalPadding * 0.6,
          fontWeight: FontWeight.w400,
          color: Colors.grey,
        ),
        bodyMedium: TextStyle(
          fontSize: height > width
              ? height * SharedConstants.generalPadding * 0.8
              : width * SharedConstants.generalPadding * 0.8,
          fontWeight: FontWeight.w400,
          color: isDarkModeTheme == true ? Colors.white : Colors.black,
        ),
        bodyLarge: TextStyle(
          fontSize: height > width
              ? height * SharedConstants.generalPadding
              : width * SharedConstants.generalPadding,
          fontWeight: FontWeight.w400,
          color: isDarkModeTheme == true ? Colors.white : Colors.black,
        ),
      ),
      iconTheme: IconThemeData(
        size: height * SharedConstants.generalPadding * 2,
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
