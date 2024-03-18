import 'package:flutter/material.dart';
// import 'package:wc_project/services/apis/device_service.dart';

class AdminPageController {
  // Get device list
  Future<List<String>> getDeviceList() async {
    List<String> deviceList = [];
    try {
      // final response = DeviceService().getDevice;
    } catch (e) {
      debugPrint('Error: $e');
    }
    return deviceList;
  }
}
