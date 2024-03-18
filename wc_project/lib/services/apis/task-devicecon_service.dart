import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wc_project/shared/constant_shared.dart';

import '../../models/task_model.dart';

class TaskDeviceConService {
  static const String _baseUrl = SharedConstants.apiBaseUrl;
  // Get Task info with device id - Get Method
  Future<Task> getTaskInfoWithDeviceId(int deviceId, String token) async {
    final url = Uri.parse('$_baseUrl${SharedConstants.taskGetwithId}$deviceId');
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token", // Bearer token ekleme
      },
    );
    if (response.statusCode == 200) {
      return Task.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get task info with device id');
    }
  }

  // Get Task info All - Get Method
  Future<List<Task>> getTaskInfoAll(String token) async {
    final url = Uri.parse('$_baseUrl${SharedConstants.taskGetAll}');
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token", // Bearer token ekleme
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      return responseData.map((e) => Task.fromJson(e)).toList();
    } else {
      throw Exception('Failed to get task info all');
    }
  }
}
