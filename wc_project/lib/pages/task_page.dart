import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wc_project/services/controllers/taskpage_controller.dart';
import 'package:wc_project/shared/constant_shared.dart';

class TaskPage extends ConsumerWidget {
  const TaskPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double height = mediaQueryData.size.height,
        width = mediaQueryData.size.width;
    TaskPageController taskPageController = TaskPageController(
      height: height,
      width: width,
      ref: ref,
      mediaQueryData: mediaQueryData,
    );
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * SharedConstants.generalPadding,
        vertical: height * SharedConstants.generalPadding,
      ),
      child: taskPageController.buildTaskPage(),
    );
  }
}
