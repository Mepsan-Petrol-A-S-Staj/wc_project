import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../services/provider/all_provider.dart';
import '../../shared/constant_shared.dart';

class AdminPageDeviceSelectWidget extends StatelessWidget {
  final WidgetRef ref;
  const AdminPageDeviceSelectWidget({
    required this.width,
    required this.deviceValue,
    required this.ref,
    super.key,
  });

  final double width;
  final String deviceValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Cihaz : ",
          style: Theme.of(context).textTheme.displayLarge,
        ),
        Padding(
          padding: EdgeInsets.only(left: width * SharedConstants.largePadding),
          // child: adminPageController.buildDeviceList(context),
          child: DropdownButton(
            // items: deviceList.map((String value) {return DropdownMenuItem<String>(value: value,child: Text(value),);}).toList(),
            items: [
              DropdownMenuItem(
                value: 'device1',
                child: Text(
                  'device1',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              DropdownMenuItem(
                value: 'device2',
                child: Text(
                  'device2',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
            ],
            onChanged: (String? value) {
              ref.read(selectedDevice.notifier).update((state) => value!);
              debugPrint('Selected Device: $value');
              // value = ref.read(selectedDevice);
            },
            value: deviceValue,
          ),
        ),
      ],
    );
  }
}
