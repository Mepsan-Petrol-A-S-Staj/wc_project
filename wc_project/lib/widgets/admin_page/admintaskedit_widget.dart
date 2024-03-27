import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wc_project/pages/admin_page.dart';

import '../../services/controllers/adminpage_controller.dart';
import '../../services/provider/all_provider.dart';

class AdminTaskEditWidget extends StatelessWidget {
  final WidgetRef ref;
  const AdminTaskEditWidget({
    required this.ref,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AdminPageController adminPageController = AdminPageController(
      height: 0,
      width: 0,
      ref: ref,
      screenType: 0,
      device: '',
      token: '',
    );
    return adminPageController.adminBuildPage('taskedit');
  }
}
