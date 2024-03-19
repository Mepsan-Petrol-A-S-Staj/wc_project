import 'package:flutter/material.dart';

import '../../shared/constant_shared.dart';
// import 'package:wc_project/services/apis/device_service.dart';

class AdminPageController {
  final double height, width;
  AdminPageController({
    required this.height,
    required this.width,
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

  Widget buildItem(
      IconData icondata, BuildContext context, String key, String title) {
    return InkWell(
      onTap: () {
        // Navigator.pushNamed(context, '/devicepage');
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
