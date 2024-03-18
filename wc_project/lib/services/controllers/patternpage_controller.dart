import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wc_project/pages/devicesave_page.dart';

import '../../pages/admin_page.dart';
import '../../pages/home_page.dart';
import '../../pages/login_page.dart';
import '../../pages/task_page.dart';
import '../../shared/constant_shared.dart';
import '../provider/all_provider.dart';

class PatternPageController {
  Future<void> sharedPreferanceStart(WidgetRef ref) async {
    bool isDeviceSaved = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDeviceSaved =
        prefs.getBool(SharedConstants.preferanceDeviceSavedControllText) ??
            false;
    debugPrint("isDeviceSaved durumu: $isDeviceSaved");
    isDeviceSaved == true
        ? null
        : ref.read(pageIndexProvider.notifier).state = 3;
  }

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

  Future<String> getIpAddress(WidgetRef ref) async {
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

  bool isKeyboardOpen() {
    bool isKeyboardOpen = false;
    var keyboardVisibilityController = KeyboardVisibilityController();
    isKeyboardOpen = keyboardVisibilityController.isVisible;
    keyboardVisibilityController.onChange.listen((bool visible) {
      isKeyboardOpen = visible;
    });
    debugPrint('Klavye durumu: $isKeyboardOpen');
    print('Klavye durumu: $isKeyboardOpen');
    return isKeyboardOpen;
  }

  Widget buildPage(int index, double height, double width) {
    // bool isKeyboardOpened = isKeyboardOpen();
    switch (index) {
      case 0:
        return HomePage(height: height, width: width);
      // return LoginPage(height: height, width: width);
      case 1:
        return LoginPage(height: height, width: width);
      case 2:
        return TaskPage(height: height, width: width);
      case 3:
        return DeviceSavePage(height: height, width: width);
      case 4:
        return AdminPage(height: height, width: width);
      default:
        return Container();
    }
  }
}
