import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../apis/user_service.dart';
import '../../provider/all_provider.dart';
import '../device_controller.dart';

enum LoginResult {
  success,
  incorrectPassword,
  userNotFound,
}

class LoginPageController {
  final WidgetRef ref;
  LoginPageController({required this.ref});
  Future<bool> userCheck(String userName, String userPassword) async {
    Map<String, dynamic> response =
        await AuthService().login(userName, userPassword);
    // if (value['isAdmin'] != 0 && value['token'] != '') {
    if (response['token'] != '') {
      // ref.read(userIsAdmin.notifier).update((state) => value['isAdmin']);
      ref
          .read(tokenProvider.notifier)
          .update((state) => response['token'].toString());
      debugPrint('\nToken: ${response['token']}'); // User id: ${value['id']}
      return true;
    } else {
      return false;
    }
  }

  Future<LoginResult> login(
    String userName,
    String userPassword,
  ) async {
    int index = 0;
    DeviceController deviceController = DeviceController(ref: ref);
    late bool isSetup;
    if (userName == "admin" && userPassword == "adminPassword") {
      isSetup = await deviceController.getDeviceSetupStatus();
      index = isSetup ? 2 : 3;
      ref.read(pageIndexProvider.notifier).update((state) => index);
      ref.read(isLoginedProvider.notifier).update((state) => true);
      return LoginResult.success;
    } else {
      bool isUser = await userCheck(userName, userPassword);
      debugPrint('Is User: $isUser');
      if (isUser) {
        isSetup = await deviceController.getDeviceSetupStatus();
        index = isSetup ? 2 : 3;
        ref.read(pageIndexProvider.notifier).update((state) => index);
        ref.read(isLoginedProvider.notifier).update((state) => true);
        return LoginResult.success;
      } else {
        debugPrint('User not found');
        return LoginResult.userNotFound;
      }
    }
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
