import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wc_project/services/apis/device_service.dart';
import '../../../models/device_model.dart';
import '../../provider/all_provider.dart';
import '../device_controller.dart';

enum DeviceSaveResult {
  success,
  notunauthorized,
  incorrectToken,
  internetNotFound,
}

class DeviceSavePageController {
  final WidgetRef ref;
  DeviceSavePageController({
    required this.ref,
  });

  String getSelectedfloorValue(String floorValue) {
    switch (floorValue) {
      case "Teras":
        ref
            .read(providerSelectedFloor.notifier)
            .update((state) => 'terrasfloor');
        return 'terrasfloor';
      case "2":
        ref
            .read(providerSelectedFloor.notifier)
            .update((state) => 'secondfloor');

        return 'secondfloor';
      case "1":
        ref
            .read(providerSelectedFloor.notifier)
            .update((state) => 'firstfloor');

        return 'firstfloor';
      case "Zemin":
        ref
            .read(providerSelectedFloor.notifier)
            .update((state) => 'groundfloor');

        return 'groundfloor';
      case "empty":
        ref
            .read(providerSelectedFloor.notifier)
            .update((state) => 'emptyfloor');
        return 'emptyfloor';
      default:
        ref
            .read(providerSelectedFloor.notifier)
            .update((state) => 'emptyfloor');
        return 'emptyfloor';
    }
  }

  String getFloorString(String floorValue) {
    switch (floorValue) {
      case "terrasfloor":
        return 'Teras';
      case "secondfloor":
        return '2';
      case "firstfloor":
        return '1';
      case "groundfloor":
        return 'Zemin';
      case "emptyfloor":
        return 'empty';
      default:
        return 'empty';
    }
  }

  Future<bool> deviceProviderService(
      String floorValue, String extraValue) async {
    String deviceName = "Arge Kat:";
    if (floorValue != "emptyfloor") {
      switch (floorValue) {
        case "terrasfloor":
          deviceName += "Teras $floorValue";
          ref.read(deviceNameProvider.notifier).update((state) => deviceName);
          break;
        case "secondfloor":
          deviceName += "2. Kat $floorValue";
          ref.read(deviceNameProvider.notifier).update((state) => deviceName);
          break;
        case "firstfloor":
          deviceName += "1. Kat $floorValue";
          ref.read(deviceNameProvider.notifier).update((state) => deviceName);
          break;
        case "groundfloor":
          deviceName += "Zemin $floorValue";
          ref.read(deviceNameProvider.notifier).update((state) => deviceName);
          break;
        default:
          deviceName += "Zemin $floorValue";
          ref.read(deviceNameProvider.notifier).update((state) => deviceName);
          break;
      }
      debugPrint('Device Name: $deviceName');
      String ipAdress = ref.watch(ipAdressProvicer);
      String token = ref.watch(tokenProvider);
      Device device = Device(
        ip: ipAdress,
        floor: floorValue,
        name: deviceName,
      );
      debugPrint(
          'Ip Adress : $ipAdress, Floor: $floorValue, DeviceName: $deviceName');
      DeviceService deviceController = DeviceService();
      DeviceSaveResult deviceSave =
          await deviceController.saveDevice(device, token);
      if (deviceSave == DeviceSaveResult.success) {
        DeviceController deviceController = DeviceController(ref: ref);
        deviceController.saveDevice(device);
        ref.read(isDeviceSavedProvider.notifier).update((state) => true);
        debugPrint('Device Saved');
        ref.read(deviceNameProvider.notifier).update((state) => deviceName);
        ref.read(isDeviceSavedProvider.notifier).update((state) => true);
        return true;
      } else {
        ref.read(isDeviceSavedProvider.notifier).update((state) => false);
        debugPrint('Device Not Saved');
        return false;
      }
    } else {
      ref.read(isDeviceSavedProvider.notifier).update((state) => false);
      debugPrint('Device Not Saved');
      return false;
    }
  }
}
