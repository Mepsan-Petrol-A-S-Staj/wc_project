// Main Libs
import 'dart:js';

import 'package:flutter/material.dart';
import 'dart:async';

// Other Libs
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wc_project/pages/devicesave_page.dart';
import 'package:wc_project/widgets/taskpagefab_widget.dart';

// Pages
import '../../../pages/admin_page.dart';
import '../../../pages/home_page.dart';
import '../../../pages/login_page.dart';
import '../../../pages/task_page.dart';
import '../../../shared/constant_shared.dart';

// Providers
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../provider/all_provider.dart';

class PatternPageController {
  final WidgetRef ref;
  PatternPageController({
    required this.ref,
  });

  // Device Saved Controll Function
  Future<void> sharedPreferanceStart() async {
    int isDeviceSaved = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDeviceSaved =
        prefs.getBool(SharedConstants.preferanceDeviceSavedControllText) == true
            ? 1
            : 0;
    ref.read(isDeviceSavedProvider.notifier).update((state) => isDeviceSaved);
    debugPrint("isDeviceSaved durumu: $isDeviceSaved");
    isDeviceSaved == 1
        ? null
        : ref.read(pageIndexProvider.notifier).update((state) => 1);
  }

  // Check Connectivity Function
  Future<bool> checkConnectivity() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    bool connectionStatus = false;
    if (result == ConnectivityResult.none) {
      debugPrint('İnternet bağlantısı yok');
      connectionStatus = false;
    } else {
      debugPrint('İnternet bağlantısı var');
      connectionStatus = true;
    }
    return connectionStatus;
  }

  // Get IP Address Function and used in checkConnectivity Function
  Future<String> getIpAddress() async {
    String ipAddress = '';

    bool isCheckConnectiviy = await checkConnectivity();
    if (isCheckConnectiviy) {
      NetworkInfo info = NetworkInfo();
      try {
        ipAddress = await info.getWifiIP() ?? '';
        ref.read(deviceIpAdressProvider.notifier).state = ipAddress;
        debugPrint('IP Adresi: $ipAddress');
      } catch (e) {
        debugPrint('IP Adresi alınamadı: $e');
      }
    }
    return ipAddress;
  }

  // Update IP Address Function
  void updateIpAddress() async {
    String ipAddress;
    const Duration updateInterval = Duration(minutes: 5);
    do {
      ipAddress = await getIpAddress();
      ref.read(ipAdressProvicer.notifier).update((state) => ipAddress);
      await Future.delayed(updateInterval);
    } while (true);
  }

  // Build Page Function
  Widget buildPage(int index, double height, double width, int deviceType) {
    // bool isKeyboardOpened = isKeyboardOpen();
    switch (index) {
      case 0:
        // LoginPageController loginPageController = LoginPageController(ref: ref);
        // loginPageController.logout();
        return const SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: HomePage(),
        );

      case 1:
        return deviceType == 0
            ? LoginPage(height: height, width: width)
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: LoginPage(height: height, width: width),
              );
      case 2:
        return const SingleChildScrollView(
            physics: BouncingScrollPhysics(), child: TaskPage());
      case 3:
        return const SingleChildScrollView(
            physics: BouncingScrollPhysics(), child: DeviceSavePage());
      case 4:
        return AdminPage(height: height, width: width);

      default:
        return Container();
    }
  }

  // Build FAB Function
  Widget buildFabWidget(int index, double height, double width) {
    switch (index) {
      // case 1:
      //   return Container();
      case 2:
        return const TaskPageFABWidget();
      // case 3:
      //   return Container();
      // case 4:
      //   return const AdminPageFABWidget();
      default:
        return const SizedBox();
    }
  }

  // Pop Invoked Function
  void onPopInvoked(bool didPop) async {
    int pageIndex = ref.watch(pageIndexProvider) ?? 0;
    bool isDeviceSaved = ref.watch(isDeviceSavedProvider) == 1 ? true : false;
    String adminPageKey = ref.watch(adminPageWidgetKey);

    if (pageIndex == 0) {
      // await ExitAppWidget.exitAppShowDialog(context);
      debugPrint('Çıkış yapılıyor');
    } else if (pageIndex == 3) {
      // pop up front page
      // BuildContext context = getContext();
      // Navigator.of(context).pop();
    } else if ((pageIndex == 4 &&
        (adminPageKey != "main" || adminPageKey != "taskedit"))) {
      ref.read(adminPageWidgetKey.notifier).update((state) => 'main');
    } else if (pageIndex == 1 && isDeviceSaved == false) {
      null;
    } else {
      ref.read(pageIndexProvider.notifier).update((state) => 0);
    }
  }
}
 // bool isKeyboardOpen() {
  //   bool isKeyboardOpen = false;
  //   var keyboardVisibilityController = KeyboardVisibilityController();
  //   isKeyboardOpen = keyboardVisibilityController.isVisible;
  //   keyboardVisibilityController.onChange.listen((bool visible) {
  //     isKeyboardOpen = visible;
  //   });
  //   debugPrint('Klavye durumu: $isKeyboardOpen');
  //   print('Klavye durumu: $isKeyboardOpen');
  //   return isKeyboardOpen;
  // }
