import 'package:wc_project/services/apis/device_service.dart';

class AdminPageController {
  // Get device list
  Future<List<String>> getDeviceList() async {
    List<String> deviceList = [];
    try {
      final response = DeviceService().getDevice;
    } catch (e) {
      print('Error: $e');
    }
    return deviceList;
  }
}
