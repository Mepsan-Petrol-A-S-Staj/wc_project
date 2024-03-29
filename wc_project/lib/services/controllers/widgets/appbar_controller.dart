import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wc_project/services/controllers/pages/loginpage_controller.dart';
import '../../provider/all_provider.dart';

class AppBarController {
  final WidgetRef ref;
  AppBarController({required this.ref});

  void logoorLoginClick(int pageIndex, int index) {
    switch (pageIndex) {
      case 0:
        ref.read(pageIndexProvider.notifier).update((state) => index);
        LoginPageController(ref: ref).logout();
        break;
      case 1:
        ref.read(pageIndexProvider.notifier).update((state) => index);
        // LoginPageController(ref: ref).login();
        break;
      case 3:
        null;
        break;
      default:
        ref.read(pageIndexProvider.notifier).update((state) => index);
        break;
    }
  }

  IconData appbarLoginorLogutButton() {
    bool isLogined = ref.watch(isLoginedProvider);
    debugPrint('isLogined: $isLogined');
    return isLogined == true ? Icons.logout_rounded : Icons.lock_outline;
  }
}
