import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wc_project/services/controllers/size_controller.dart';
import 'package:wc_project/shared/constant_shared.dart';
import 'package:wc_project/shared/list_shared.dart';

import '../services/controllers/adminpage_controller.dart';
import '../services/provider/all_provider.dart';

class AdminPage extends StatelessWidget {
  final double height, width;

  final List<String> deviceList = ['device1', 'device2']; // Örnek cihaz listesi

  AdminPage({
    required this.height,
    required this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    SizeController sizeController = SizeController(
        height: mediaQueryData.size.height, width: mediaQueryData.size.width);
    int screenType = sizeController.getScreenType(mediaQueryData);
    return Consumer(builder: (context, ref, child) {
      AdminPageController adminPageController = AdminPageController(
        height: mediaQueryData.size.height,
        width: mediaQueryData.size.width,
        ref: ref,
        screenType: screenType,
      );
      String widgetKey = ref.watch(adminPageWidgetKey);
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
                  // items: deviceList.map((String value) {return DropdownMenuItem<String>(value: value,child: Text(value),);}).toList(),

                  items: [
                    DropdownMenuItem(
                      value: 'device1',
                      child: Text(
                        'device1',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
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
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: height * SharedConstants.generalPadding),
            child: SizedBox(
              height: height * SharedConstants.generalSize / 16,
              child: Drawer(
                backgroundColor:
                    Theme.of(context).colorScheme.secondaryContainer,
                width: double.infinity,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    height * SharedConstants.generalSize,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: adminPageController.adminBuildPage(widgetKey),
          ),
        ],
      );
    });
  }
}
