import 'package:flutter/material.dart';

import '../../services/controllers/pages/adminpage_controller.dart';
import '../../shared/constant_shared.dart';
import '../../shared/list_shared.dart';

class AdminPageMainWidget extends StatelessWidget {
  const AdminPageMainWidget({
    required this.screenType,
    required this.height,
    required this.width,
    required this.adminPageController,
    super.key,

  });

  final double height,width;
  final int screenType;
  final AdminPageController adminPageController;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: screenType == 0 ? 2 : 4,
      mainAxisSpacing: height * SharedConstants.generalPadding,
      crossAxisSpacing: width * SharedConstants.generalPadding,
      children: SharedList.adminPageCardList
          .map(
            (e) => adminPageController.buildItem(
                e.icon, context, e.key, e.value),
          )
          .toList(),
    );
  }
}
