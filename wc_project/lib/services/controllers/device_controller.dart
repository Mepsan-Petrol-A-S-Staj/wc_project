import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wc_project/models/device_model.dart';
import 'package:wc_project/services/provider/all_provider.dart';

import '../../shared/constant_shared.dart';

class DeviceController {
  final WidgetRef ref;
  DeviceController({
    required this.ref,
  });
  Future<bool> getDeviceSetupStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDeviceSaved =
        prefs.getBool(SharedConstants.preferanceDeviceSavedControllText) ??
            false;
    // int isDeviceSavedInt = isDeviceSaved ? 1 : 0;
    ref.read(isDeviceSavedProvider.notifier).update((state) => isDeviceSaved);
    return isDeviceSaved;
  }

  void saveDevice(Device device) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(SharedConstants.preferanceDeviceSavedControllText, true);
    prefs.setString(SharedConstants.preferaceDeviceName, device.deviceName);
    prefs.setInt(
        SharedConstants.preferanceDeviceId, ref.watch(deviceIdProvider));
    debugPrint('Device Saved: ${device.deviceName} with id: ${device.id}');
    ref.read(isDeviceSavedProvider.notifier).update((state) => true);
  }

  Future<int> getDeviceId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(SharedConstants.preferanceDeviceId) ?? 0;
  }
}
