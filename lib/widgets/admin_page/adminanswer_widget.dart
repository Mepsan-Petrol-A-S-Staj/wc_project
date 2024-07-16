import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wc_project/services/apis/survey_service.dart';
import 'package:wc_project/services/provider/all_provider.dart';

import '../../models/survey_model.dart';

class AdminAnswerWidget extends ConsumerWidget {
  const AdminAnswerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<Survey>>(
      future: _fetchUserList(ref),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text('No survey found.'),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final survey = snapshot.data![index];
              return ListTile(
                title: Text("Puan: ${survey.rating.toString()}"),
                subtitle: Text('ID: ${survey.deviceId}'),
              );
            },
          );
        }
      },
    );
  }

  Future<List<Survey>> _fetchUserList(WidgetRef ref) async {
    SurveyService userService = SurveyService();
    String token = ref.read(tokenProvider);
    int selectedDeviceIdValue = ref.read(selectedDeviceId);
    List<Survey> users;
    selectedDeviceIdValue == 0
        ? users = await userService.getAllSurvey(token)
        : users =
            await userService.getSurveyDevice(selectedDeviceIdValue, token);

    return users;
  }
}
