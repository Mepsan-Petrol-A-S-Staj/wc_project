import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wc_project/services/controllers/pages/adminpage_controller.dart';

import '../../models/task_model.dart';

class AdminTaskWidget extends StatelessWidget {
  final WidgetRef ref;

  const AdminTaskWidget({
    required this.ref,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _fetchTaskList(context),
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
            child: Text('No tasks found.'),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final task = snapshot.data![index];
              return ListTile(
                title: Text(task.name),
                subtitle: Text('Frequency: ${task.frequency.toString()}'),
              );
            },
          );
        }
      },
    );
  }

  Future<List<Task>> _fetchTaskList(BuildContext context) async {
    AdminPageController adminPageController = AdminPageController(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      ref: ref,
      screenType: 0,
    );
    int deviceId = await adminPageController.getTaskInfoWithDeviceId();
    if (deviceId == 0) {
      return [];
    }
    return await adminPageController.getTaskInfoWithDeviceId();
  }
}
