import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wc_project/shared/constant_shared.dart';

import '../../models/survey_model.dart';
class SurveyService{
  static const String _baseUrl = SharedConstants.apiBaseUrl;
  // Survey Save - Post Method
  Future<void> saveSurvey(Survey survey, String token) async {
    final url = Uri.parse('$_baseUrl${SharedConstants.surveySave}');
    final body = jsonEncode(survey);

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token", // Bearer token ekleme
      },
      body: body,
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to save survey');
    }
  }
  // ?Survey Montly - Post Method
  Future<void> montlySurvey(Survey survey, String token) async {
    final url = Uri.parse('$_baseUrl${SharedConstants.surveyMontly}');
    final body = jsonEncode(survey);

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token", // Bearer token ekleme
      },
      body: body,
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to save survey');
    }
  }

  // Get Survey with id - Get Method
  Future<Survey> getSurvey(int id, String token) async {
    final url = Uri.parse('$_baseUrl${SharedConstants.surveyGetwithId}$id');
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
      return Survey.fromJson(data);
    } else {
      throw Exception('Failed to get survey');
    }
  }
  // Get Survey with device id - Get Method
  Future<Survey> getSurveyDevice(int id, String token) async {
    final url = Uri.parse('$_baseUrl${SharedConstants.surveyGetwithId}$id');
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
      return Survey.fromJson(data);
    } else {
      throw Exception('Failed to get survey');
    }
  }

  // Delete Survey with id - Get Method?
  Future<void> deleteSurvey(int id, String token) async {
    final url = Uri.parse('$_baseUrl${SharedConstants.surveyDeletewithId}$id');
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token", // Bearer token ekleme
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete survey');
    }
  }
  // Get Survey All - Get Method
  Future<List<Survey>> getAllSurvey(String token) async {
    final url = Uri.parse('$_baseUrl${SharedConstants.surveyGetAll}');
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
      return data.map((e) => Survey.fromJson(e)).toList();
    } else {
      throw Exception('Failed to get all survey');
    }
  }

}
