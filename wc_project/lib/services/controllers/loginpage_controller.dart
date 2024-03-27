import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../apis/user_service.dart';
import '../provider/all_provider.dart';

class LoginPageController {
  final WidgetRef ref;
  LoginPageController({required this.ref});
  Future<bool> userCheck(String userName, String userPassword) async {
    Future<Map<String, dynamic>> response =
        AuthService().login(userName, userPassword);
    response.then((value) {
      if (value['id'] != 0 && value['token'] != '') {
        ref.read(userIdProvider.notifier).update((state) => value['id']);
        ref
            .read(tokenProvider.notifier)
            .update((state) => value['token'].toString());
        debugPrint('User id: ${value['id']}\nToken: ${value['token']}');
        return true;
      } else {
        return false;
      }
    });
    return false;
  }

  void login() {
    ref.watch(isLoginedProvider.notifier).update((state) => true);
  }

  void logout() {
    ref.watch(isLoginedProvider.notifier).update((state) => false);
  }

  void isAFK() async {
    int counter = ref.watch(afkTimeCounter);
    while (true) {
      counter = ref.watch(afkTimeCounter);
      if (counter == 15) {
        counterReset();
        logout();
        break;
      }
      // delay 1 second
      await Future.delayed(const Duration(minutes: 1));
      ref.read(afkTimeCounter.notifier).update((state) => state + 1);
    }
  }

  void counterReset() {
    ref.read(afkTimeCounter.notifier).update((state) => 0);
  }
}
