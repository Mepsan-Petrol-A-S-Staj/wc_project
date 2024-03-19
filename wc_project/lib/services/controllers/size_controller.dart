import 'package:flutter/material.dart';

class SizeController {
  final double height, width;

  SizeController({
    required this.height,
    required this.width,
  });
  int getScreenType(MediaQueryData mediaQueryData) {
    // 0 mobile, 1 tablet, 2 desktop
    int index = 0;
    double value = width;
    bool deviceRotated = mediaQueryData.orientation ==
        Orientation.portrait; // true: portrait, false: landscape
    // double value = deviceRotated ? width : height;
    if (value > 600) {
      // width > 768 -> desktop
      index = 2;
      debugPrint(
          "screenType: $index,  value: $value, width: $width, height: $height, deviceRotated: $deviceRotated");
      return index;
    } else if (value > 450 && value <= 600) {
      // 480 < width <= 768 -> tablet
      index = 1;
      debugPrint(
          "screenType: $index,  value: $value, width: $width, height: $height, deviceRotated: $deviceRotated");
      return index;
    } else {
      // width <= 480 -> mobile
      index = 0;
      debugPrint(
          "screenType: $index,  value: $value, width: $width, height: $height, deviceRotated: $deviceRotated");
      return index;
    }
  }
}
