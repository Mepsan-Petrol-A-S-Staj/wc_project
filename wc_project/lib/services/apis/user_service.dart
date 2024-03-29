import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:wc_project/shared/constant_shared.dart';
import '../../models/user_model.dart';

// User Login - Get Method
class AuthService {
  static const String _baseUrl = SharedConstants.apiBaseUrl;

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final url = Uri.parse('$_baseUrl${SharedConstants.authLogin}');
      final body = jsonEncode({"username": username, "password": password});

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      debugPrint('Response: ${response.body}');
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final data = responseData['data'];
        // final isAdmin = data['isAdmin'];
        final token = data['token'];
        // return {'id': isAdmin, 'token': token};
        debugPrint('Token: $token');
        return {'token': token};
      } else {
        return {'token': ''};
      }
    } catch (e) {
      debugPrint('Exception occurred while logging in: $e');
      return {'id': 0, 'token': ''};
    }
  }
}

class UserService {
  static const String _baseUrl = SharedConstants.apiBaseUrl;
  // User Save - Post Method
  Future<void> saveUser(User user, String token) async {
    final url = Uri.parse('$_baseUrl${SharedConstants.userSave}');
    final body = jsonEncode(user);

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token", // Bearer token ekleme
      },
      body: body,
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to save user');
    }
  }

  // Get User with id - Get Method
  Future<User> getUser(int id, String token) async {
    final url = Uri.parse('$_baseUrl${SharedConstants.userGetwithId}$id');
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token", // Bearer token ekleme
      },
    );
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get user');
    }
  }

  // Delete User with id - Get Method
  Future<void> deleteUser(int id, String token) async {
    final url = Uri.parse('$_baseUrl${SharedConstants.userDeletewithId}$id');
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token", // Bearer token ekleme
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete user');
    }
  }

  // Get User All - Get Method
  Future<List<User>> getAllUser(String token) async {
    final url = Uri.parse('$_baseUrl${SharedConstants.userGetAll}');
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token", // Bearer token ekleme
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      return responseData.map((e) => User.fromJson(e)).toList();
    } else {
      throw Exception('Failed to get all user');
    }
  }

  // Get user employee - Get Method
  Future<List<User>> getEmployee(String token) async {
    final url = Uri.parse('$_baseUrl/user/employee');
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token", // Bearer token ekleme
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      return responseData.map((e) => User.fromJson(e)).toList();
    } else {
      throw Exception('Failed to get employee');
    }
  }
  /*
  // !Update User with id - Post Method
  Future<void> updateUser(User user, String token) async {
    final url = Uri.parse('$_baseUrl/user/update');
    final body = jsonEncode(user);

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token", // Bearer token ekleme
      },
      body: body,
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update user');
    }
  }
  */
}
