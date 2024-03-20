import 'package:flutter/material.dart';
import 'package:wc_project/shared/constant_shared.dart';

import '../shared/list_shared.dart';
import '../widgets/mobile/taskpagecard_widget.dart';
import '../widgets/tablet&desktop/taskpagecard_widget.dart';

class TaskPage extends StatelessWidget {
  final double height, width;
  const TaskPage({
    required this.height,
    required this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * SharedConstants.generalPadding,
        vertical: height * SharedConstants.generalPadding,
      ),
      child: Column(
        children: [
          // TaskPageMobile(height: height, width: width),
          TaskPageTabletandDesktopCardWidget(height: height, width: width),
        ],
      ),
    );
  }
}
