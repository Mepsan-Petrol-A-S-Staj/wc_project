// ignore: file_names
import 'dart:convert' show jsonDecode;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wc_project/shared/constant_shared.dart';
import '../../models/task_model.dart';

class TaskDeviceConService {
  static const String _baseUrl = SharedConstants.apiBaseUrlV2;

  // Get Task info with device id - Get Method
  Future<List<Task>> getTaskInfoWithDeviceId(
      String deviceId, String token) async {
    try {
      final url =
          Uri.parse('$_baseUrl${SharedConstants.taskGetwithId}$deviceId');
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token", // Bearer token ekleme
        },
      );
      switch (response.statusCode) {
        case 200:
          final data = jsonDecode(response.body);
          if (data['success'] == false) {
            return [];
          } else {
            debugPrint('Task Info: $data');
            final List<dynamic> taskData = data['data'];
            List<Task> tasks = [];
            for (var taskJson in taskData) {
              Task task = Task.fromJson(taskJson);
              tasks.add(task);
            }
            return tasks;
          }
        case 401:
          debugPrint('Unauthorized Error');
          return [];
        case 403:
          debugPrint('Forbidden Error');
          return [];

        case 404:
          debugPrint('error: Not Found Error');
          return [];
        default:
          debugPrint('error: Failed to get task info with device id');
          return [];
      }
    } catch (e) {
      debugPrint('Exception occurred while fetching task info: $e');
      return [];
    }
  }

  // Get Task info All - Get Method
  Future<List<Task>> getTaskInfoAll(String token) async {
    try {
      final url = Uri.parse('$_baseUrl${SharedConstants.taskGetAll}');
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token", // Bearer token ekleme
        },
      );
      switch (response.statusCode) {
        case 200:
          final List<dynamic> responseData = jsonDecode(response.body);
          return responseData.map((e) => Task.fromJson(e)).toList();
        case 401:
          throw Exception('Unauthorized Error');
        case 403:
          throw Exception('Forbidden Error');
        case 404:
          throw Exception('Not Found Error');
        default:
          throw Exception('Failed to get task info all');
      }
    } catch (e) {
      debugPrint('Exception occurred while fetching task info: $e');
      throw Exception(e.toString());
    }
  }
}
