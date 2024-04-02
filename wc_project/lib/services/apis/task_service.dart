import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wc_project/shared/constant_shared.dart';
import '../../models/task_model.dart';

class TaskService {
  static const String _baseUrl = SharedConstants.apiBaseUrlV2;

  // Task Save - Post Method
  Future<void> saveTask(Task task, String token) async {
    final url = Uri.parse('$_baseUrl${SharedConstants.taskSave}');
    final body = jsonEncode(task);

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token", // Bearer token ekleme
      },
      body: body,
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to save task');
    }
  }

  // Get Task with id - Get Method
  Future<Task> getTask(int id, String token) async {
    final url = Uri.parse('$_baseUrl${SharedConstants.taskGetwithId}$id');
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
      return Task.fromJson(data);
    } else {
      throw Exception('Failed to get task');
    }
  }

  // Delete Task with id - Get Method
  Future<void> deleteTask(int id, String token) async {
    final url = Uri.parse('$_baseUrl${SharedConstants.taskDeletewithId}/$id');
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token", // Bearer token ekleme
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete task');
    }
  }

  // Get Task All - Get Method
  Future<List<Task>> getAllTask(String token) async {
    final url = Uri.parse('$_baseUrl${SharedConstants.taskGetAll}');
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token", // Bearer token ekleme
      },
    );
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final data = responseData['data'] as List;
      return data.map((e) => Task.fromJson(e)).toList();
    } else {
      throw Exception('Failed to get all task');
    }
  }

  // ?Get Task AllRE - Get Method
  Future<List<Task>> getAllTaskRE(String token) async {
    final url = Uri.parse('$_baseUrl${SharedConstants.taskGetAllRE}');
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token", // Bearer token ekleme
      },
    );
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final data = responseData['data'] as List;
      return data.map((e) => Task.fromJson(e)).toList();
    } else {
      throw Exception('Failed to get all task');
    }
  }
  /* TODO: Bence Yapılması Lazım
  // !Update Task with id - Post Method
  Future<void> updateTask(Task task, String token) async {
    final url = Uri.parse('$_baseUrl${SharedConstants.taskSave}');
    final body = jsonEncode(task);
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token", // Bearer token ekleme
      },
      body: body,
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update task');
    }
  }
  */
}
