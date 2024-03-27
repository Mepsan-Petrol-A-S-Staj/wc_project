import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wc_project/shared/constant_shared.dart';

import '../../models/device_model.dart';

class DeviceService {
  static const String _baseUrl = SharedConstants.apiBaseUrl;
  // Device Save - Post Method
  Future<void> saveDevice(Device device, String token) async {
    final url = Uri.parse('$_baseUrl${SharedConstants.deviceSave}');
    final body = jsonEncode(device);

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token", // Bearer token ekleme
      },
      body: body,
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to save device');
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
  Future<List<dynamic>> getAllDevice(String token) async {
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
}
