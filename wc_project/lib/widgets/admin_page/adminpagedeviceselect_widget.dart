import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wc_project/services/controllers/pages/adminpage_controller.dart';

import '../../services/provider/all_provider.dart';
import '../../shared/constant_shared.dart';

class AdminPageDeviceSelectWidget extends StatelessWidget {
  final WidgetRef ref;
  final double width;
  final String selectedDeviceValue;

  const AdminPageDeviceSelectWidget({
    required this.width,
    required this.ref,
    required this.selectedDeviceValue,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AdminPageController adminPageController = AdminPageController(
      height: 0,
      width: width,
      ref: ref,
      screenType: 0,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Cihaz : ",
          style: Theme.of(context).textTheme.displayLarge,
        ),
        Padding(
          padding: EdgeInsets.only(left: width * SharedConstants.largePadding),
          child:
              adminPageController.buildDeviceList(context, selectedDeviceValue),
        ),
      ],
    );
  }
}
