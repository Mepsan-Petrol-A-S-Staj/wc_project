import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wc_project/services/controllers/size_controller.dart';
import 'package:wc_project/shared/constant_shared.dart';
import '../services/controllers/pages/adminpage_controller.dart';
import '../services/provider/all_provider.dart';
import '../widgets/admin_page/adminpagedeviceselect_widget.dart';

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
          // Admin App Bar
          FutureBuilder<Widget>(
            future: adminPageController.adminBuildSecondAppBar(),
            builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return snapshot.data ?? const SizedBox(); // widget here
                }
              }
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: height * SharedConstants.generalPadding),
            child: SizedBox(
              height: height * SharedConstants.generalSize / 16,
              // Drawer
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
            child: FutureBuilder<Widget>(
              future: adminPageController.adminBuildPage(widgetKey),
              builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return snapshot.data ?? const SizedBox(); // widget here
                  }
                }
              },
            ),
          ),
        ],
      );
    });
  }
}
