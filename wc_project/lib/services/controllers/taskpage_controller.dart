import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wc_project/services/controllers/size_controller.dart';
import 'package:wc_project/widgets/mobile/taskpagecard_widget.dart';
import 'package:wc_project/widgets/tablet&desktop/taskpagecard_widget.dart';

class TaskPageController {
  final double height, width;
  final WidgetRef ref;
  final MediaQueryData mediaQueryData;
  TaskPageController({
    required this.height,
    required this.width,
    required this.ref,
    required this.mediaQueryData,
  });
  Widget buildTaskPage() {
    SizeController sizeController =
        SizeController(height: height, width: width);
    int type = sizeController.getScreenType(mediaQueryData);
    switch (type) {
      case 0:
        return TaskPageMobile(height: height, width: width);
      case 1:
        return TaskPageTabletandDesktopCardWidget(height: height, width: width);
      case 2:
        return TaskPageTabletandDesktopCardWidget(height: height, width: width);
      default:
        return TaskPageMobile(height: height, width: width);
    }
  }
}
