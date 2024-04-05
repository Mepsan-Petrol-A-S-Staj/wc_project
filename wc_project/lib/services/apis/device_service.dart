import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:wc_project/shared/constant_shared.dart';

import '../../models/device_model.dart';
import '../controllers/pages/devicesavepage_controller.dart';
import '../provider/all_provider.dart';

class DeviceService {
  final WidgetRef ref;
  DeviceService({
    required this.ref,
  });
  static const String _baseUrl = SharedConstants.apiBaseUrlV2;
  // Device Save - Post Method
  Future<DeviceSaveResult> saveDevice(Device device, String token) async {
    final url = Uri.parse('$_baseUrl${SharedConstants.deviceSave}');
    final body = jsonEncode(device);
    debugPrint('Device Save Body: $body');
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token", // Bearer token ekleme
      },
      body: body,
    );
    switch (response.statusCode) {
      case 200:
        final responseData = jsonDecode(response.body);
        final bool isdeviceSaved = responseData['success'];
        if (!isdeviceSaved) {
          return DeviceSaveResult.internetNotFound;
        } else {
          final data = responseData['data']['id'];
          debugPrint('Device saved with id: $data');
          ref.read(deviceIdProvider.notifier).update((state) => data);
          return DeviceSaveResult.success;
        }
      case 201:
        return DeviceSaveResult.success;
      case 401:
        debugPrint('Unauthorized Error');
        return DeviceSaveResult.notunauthorized;
      case 403:
        debugPrint('Forbidden Error');
        return DeviceSaveResult.incorrectToken;
      case 404:
        debugPrint('Not Found Error');
        return DeviceSaveResult.internetNotFound;
      default:
        debugPrint('Failed to save device');
        return DeviceSaveResult.internetNotFound;
    }
  }

  // Get Device with id - Get Method
  Future<Device> getDevice(int id, String token) async {
    final url = Uri.parse('$_baseUrl${SharedConstants.deviceGetwithId}$id');
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token", // Bearer token ekleme
      },
    );
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final data = responseData['data'];
      return Device.fromJson(data);
    } else {
      throw Exception('Failed to get device');
    }
  }

  // Delete Device with id - Get Method
  Future<void> deleteDevice(int id, String token) async {
    final url = Uri.parse('$_baseUrl${SharedConstants.deviceDeletewithId}/$id');
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token", // Bearer token ekleme
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete device');
    }
  }

  // Get Device All - Get Method
  Future<List<Device>> getAllDevice(String token) async {
    try {
      final url = Uri.parse('$_baseUrl${SharedConstants.deviceGetAll}');
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token", // Bearer token ekleme
        },
      );

      switch (response.statusCode) {
        case 200:
          final responseData = jsonDecode(response.body);
          final data = responseData['data'] as List;
          return data.map((e) => Device.fromJson(e)).toList();
        case 201:
          final responseData = jsonDecode(response.body);
          final data = responseData['data'] as List;
          return data.map((e) => Device.fromJson(e)).toList();
        case 401:
          debugPrint('Unauthorized Error');
          return [];
        case 403:
          debugPrint('Forbidden Error');
          return [];
        case 404:
          debugPrint('Not Found Error');
          return [];
        default:
          debugPrint('Failed to get all device');
          return [];
      }
    } catch (e) {
      debugPrint('Exception occurred while fetching all device: $e');
      return [];
    }
  }

  Future<int> getDeviceIdbyDeviceName(String deviceName) async {
    final String token = ref.watch(tokenProvider);
    debugPrint('Get Device Token Degeri: $token');
    try {
      final url = Uri.parse(
          '$_baseUrl${SharedConstants.deviceGetIdbyDeviceName}$deviceName');
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      switch (response.statusCode) {
        case 200:
          int id;
          final responseData = jsonDecode(response.body);
          final data = responseData['data'];
          data != null ? id = data['id'] : id = 0;
          debugPrint('Device Id: $id');
          ref.read(selectedDeviceId.notifier).update((state) => id);
          return id;
        case 201:
          final responseData = jsonDecode(response.body);
          final data = responseData['data'];
          final int id = data['id'];
          ref.read(selectedDeviceId.notifier).update((state) => id);
          return id;
        case 401:
          debugPrint('Unauthorized Error');
          return 0;
        case 403:
          debugPrint('Forbidden Error');
          return 0;
        case 404:
          debugPrint('Not Found Error');
          return 0;
        default:
          debugPrint('Failed to get all device');
          return 0;
      }
    } catch (e) {
      debugPrint('Exception occurred while fetching all device: $e');
      return 0;
    }
  }
}
