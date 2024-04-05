import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wc_project/services/provider/all_provider.dart';

class AdminAnswerWidget extends StatelessWidget {
  const AdminAnswerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        String selectedDeviceValue = ref.watch(selectedDevice);
        return Text('Admin Answer Widget');
        // return FutureBuilder(future: , builder: builder)
      },
    );
  }
}
