import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wc_project/services/controllers/size_controller.dart';
import 'package:wc_project/widgets/mobile/homepage/homepage_widget.dart';
import 'package:wc_project/widgets/tablet&desktop/homepage/homepage_widget.dart';

import '../../widgets/mobile/homepage/ratingcontainer_widget.dart';
import '../../widgets/tablet&desktop/homepage/ratingcontainer_widget.dart';

class HomePageController {
  final MediaQueryData mediaQueryData;
  final double height, width;
  final WidgetRef ref;
  HomePageController({
    required this.mediaQueryData,
    required this.height,
    required this.width,
    required this.ref,
  });

  Widget buildRatingWidget() {
    SizeController sizeController = SizeController(
      height: height,
      width: width,
    );
    int type = sizeController.getScreenType(mediaQueryData);
    switch (type) {
      case 0:
        return RatingContainerMobileWidget(
            width: width, height: height, ref: ref);
      case 1:
        return RatingContainerTabletandDesktopWidget(width: width, ref: ref);
      case 2:
        return RatingContainerTabletandDesktopWidget(width: width, ref: ref);
      default:
        return RatingContainerMobileWidget(
            width: width, height: height, ref: ref);
    }
  }

  Widget buildAnswerandSubmitWidget() {
    SizeController sizeController = SizeController(
      height: height,
      width: width,
    );
    int type = sizeController.getScreenType(mediaQueryData);
    switch (type) {
      case 0:
        return HomePageMobileWidget(width: width, height: height, ref: ref);
      case 1:
        return HomePageTabletandDesktopWidget(
            width: width, height: height, ref: ref);
      case 2:
        return HomePageTabletandDesktopWidget(
            width: width, height: height, ref: ref);
      default:
        return HomePageMobileWidget(width: width, height: height, ref: ref);
    }
  }
}
