import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../services/controllers/pages/adminpage_controller.dart';
// ignore: unused_import
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
      token: '',
    );

    return FutureBuilder<Widget>(
      future: adminPageController.adminBuildPage('taskedit'),
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return snapshot.data ?? const SizedBox(); // widget here
          }
        }
      },
    );
  }
}
