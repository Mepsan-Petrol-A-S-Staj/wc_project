import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wc_project/services/controllers/pages/adminpage_controller.dart';

import '../../services/provider/all_provider.dart';
import '../../shared/constant_shared.dart';

class AdminPageDeviceSelectWidget extends StatefulWidget {
  final WidgetRef ref;
  final double width;

  const AdminPageDeviceSelectWidget({
    required this.width,
    required this.ref,
    super.key,
  });

  @override
  State<AdminPageDeviceSelectWidget> createState() =>
      _AdminPageDeviceSelectWidgetState();
}

class _AdminPageDeviceSelectWidgetState
    extends State<AdminPageDeviceSelectWidget> {
  @override
  Widget build(BuildContext context) {
    AdminPageController adminPageController = AdminPageController(
      height: 0,
      width: widget.width,
      ref: widget.ref,
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
          padding: EdgeInsets.only(
              left: widget.width * SharedConstants.largePadding),
          child: adminPageController.buildDeviceList(context),
        ),
      ],
    );
  }
}
