import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../apis/user_service.dart';
import '../../provider/all_provider.dart';
import '../device_controller.dart';

enum LoginResult {
  success,
  notunauthorized,
  incorrectPassword,
  userNotFound,
}

class LoginPageController {
  final WidgetRef ref;
  LoginPageController({required this.ref});
  Future<bool> userCheck(String userName, String userPassword) async {
    Map<String, dynamic> response =
        await AuthService().login(userName, userPassword);
    if (response['success'] == true) {
      // Updae the provider values
      ref.read(userIdProvider.notifier).update((state) => response['id']);
      ref.read(tokenProvider.notifier).update((state) => response['token']);
      ref.read(userIsAdmin.notifier).update((state) => response['isAdmin']);
      debugPrint('User Id: ${response['id']}'); // User id: ${value['id']}
      return true;
    } else {
      return false;
    }
  }

  Future<LoginResult> login(String userName, String userPassword) async {
    int index = 1;
    DeviceController deviceController = DeviceController(ref: ref);
    late bool isSetup;
    bool isUser = await userCheck(userName, userPassword);
    debugPrint('Is User: $isUser');
    if (isUser) {
      isSetup = await deviceController.getDeviceSetupStatus();
      bool isAdmin = ref.watch(userIsAdmin);
      if (isSetup == false) {
        // If the device is not set up
        if (isAdmin) {
          index = 3;
        } else {
          return LoginResult.notunauthorized;
        }
      } else {
        // If the device is set up
        if (isAdmin) {
          index = 4;
        } else {
          index = 2;
        }
      }
      ref.read(pageIndexProvider.notifier).update((state) => index);
      ref.read(isLoginedProvider.notifier).update((state) => true);
      return LoginResult.success;
    } else {
      debugPrint('User not found');
      return LoginResult.userNotFound;
    }
  }

  void logout() {
    ref.watch(isLoginedProvider.notifier).update((state) => false);
    ref.watch(userIsAdmin.notifier).update((state) => false);
    ref.watch(userIdProvider.notifier).update((state) => 0);
    ref.watch(tokenProvider.notifier).update((state) => '');
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
