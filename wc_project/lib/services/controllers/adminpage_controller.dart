import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wc_project/widgets/admin_page/adminanswer_widget.dart';
import 'package:wc_project/widgets/admin_page/admindevice_widget.dart';
import 'package:wc_project/widgets/admin_page/adminuser_widget.dart';

import '../../shared/constant_shared.dart';
import '../../widgets/admin_page/adminpagemain_widget.dart';
import '../../widgets/admin_page/admintask_widget.dart';
import '../provider/all_provider.dart';
// import 'package:wc_project/services/apis/device_service.dart';

class AdminPageController {
  final double height, width;
  final WidgetRef ref;
  final int screenType;
  AdminPageController({
    required this.height,
    required this.width,
    required this.ref,
    required this.screenType,
  });
  // Get device list
  Future<List<String>> getDeviceList() async {
    List<String> deviceList = [];
    try {
      // final response = DeviceService().getDevice;
    } catch (e) {
      debugPrint('Error: $e');
    }
    return deviceList;
  }

  Widget adminBuildPage(String widgetKey) {
    switch (widgetKey) {
      case 'main':
        ref.read(adminPageWidgetKey.notifier).state = 'main';
        return AdminPageMainWidget(
          screenType: screenType,
          height: height,
          width: width,
          adminPageController: this,
        );
      case 'task':
        ref.read(adminPageWidgetKey.notifier).state = 'task';
        return const AdminTaskWidget();
      case 'user':
        return const AdminUserWidget();
      case 'answer':
        return const AdminAnswerWidget();
      case 'device':
        return const AdminDeviceWidget();
      default:
        return AdminPageMainWidget(
          screenType: screenType,
          height: height,
          width: width,
          adminPageController: this,
        );
    }
  }

  Widget buildItem(
      IconData icondata, BuildContext context, String key, String title) {
    return InkWell(
      onTap: () {
        ref.read(adminPageWidgetKey.notifier).state = key;
      },
      child: Card(
        color: Theme.of(context).colorScheme.secondaryContainer,
        key: ValueKey(key),
        child: title != ''
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: height * SharedConstants.generalPadding,
                    ),
                    child: Icon(
                      icondata,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                ],
              )
            : Icon(
                icondata,
                color: Theme.of(context).iconTheme.color,
              ),
      ),
    );
  }
}
