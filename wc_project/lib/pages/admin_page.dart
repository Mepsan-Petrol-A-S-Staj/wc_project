import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wc_project/shared/constants_shared.dart';

import '../services/all_provider.dart';

class AdminPage extends ConsumerWidget {
  final double height, width;
  final List<String> deviceList = ['device1', 'device2']; // Örnek cihaz listesi

  AdminPage({
    required this.height,
    required this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Cihaz : ",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: width * SharedConstants.largePadding),
              child: DropdownButton<String>(
                // items: deviceList.map((String value) {
                //       return DropdownMenuItem<String>(
                //         value: value,
                //         child: Text(value),
                //       );
                //     }).toList(),
                items: [
                  DropdownMenuItem(
                    child: Text(
                      'device1',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    value: 'device1',
                  ),
                ],
                onChanged: (String? value) {
                  // ref.read(selectedDevice.notifier).state = value!;
                },
                value: 'device1',
              ),
            ),
          ],
        ),
        // TabBar(tabs: [
        //   Tab(
        //     text: "Cihaz Ekle",
        //   ),
        //   Tab(
        //     text: "Cihaz Sil",
        //   ),
        // ]),
      ],
    );
  }
}
