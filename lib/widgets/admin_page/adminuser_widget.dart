import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wc_project/models/user_model.dart';
import 'package:wc_project/services/provider/all_provider.dart';

import '../../services/apis/user_service.dart';

class AdminUserWidget extends ConsumerWidget {
  const AdminUserWidget({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<User>>(
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
            child: Text('No users found.'),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final user = snapshot.data![index];
              return ListTile(
                title: Text(user.name),
                subtitle: Text('ID: ${user.userId}'),
              );
            },
          );
        }
      },
    );
  }

  Future<List<User>> _fetchUserList(WidgetRef ref) async {
    UserService userService = UserService();
    String token = ref.read(tokenProvider);
    final List<User> users = await userService.getAllUser(token);
    return users;
  }
}
