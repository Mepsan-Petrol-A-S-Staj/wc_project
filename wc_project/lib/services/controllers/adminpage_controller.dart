import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wc_project/widgets/admin_page/adminanswer_widget.dart';
import 'package:wc_project/widgets/admin_page/admindevice_widget.dart';
import 'package:wc_project/widgets/admin_page/adminuser_widget.dart';
import '../../shared/constant_shared.dart';
import '../../widgets/admin_page/adminpagemain_widget.dart';
import '../../widgets/admin_page/admintask_widget.dart';
import '../../widgets/admin_page/admintaskedit_widget.dart';
import '../apis/device_service.dart';
import '../apis/task-devicecon_service.dart';
import '../provider/all_provider.dart';
// import 'package:wc_project/services/apis/device_service.dart';

class AdminPageController {
  final double height, width;
  final WidgetRef ref;
  final int screenType;
  final String device;
  final String token;
  AdminPageController({
    required this.height,
    required this.width,
    required this.ref,
    required this.screenType,
    required this.device,
    required this.token,
  });
  
  // Get device list
  Future<List<String>> getDeviceList() async {
    String token = ref.watch(tokenProvider);
    List<String> deviceList = [];
    try {
      final response = await DeviceService()
          .getAllDevice(token); // getAllDevice fonksiyonu çağrıldı
      if (response.isNotEmpty) {
        for (var i = 0; i < response.length; i++) {
          deviceList.add(response[i].name);
        }
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
    return deviceList;
  }

  Future<dynamic> getTaskInfoWithDeviceId() async {
    String deviceId = ref.read(selectedDevice);
    String token = ref.watch(tokenProvider);
    try {
      final response = await TaskDeviceConService().getTaskInfoWithDeviceId(
          deviceId, token); // getTaskInfoWithDeviceId fonksiyonu çağrıldı
      return response;
    } catch (e) {
      debugPrint('Error: $e');
    }
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
      case 'taskedit':
        return AdminTaskEditWidget(ref: ref);

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
          color: Theme.of(context).colorScheme.tertiaryContainer,
          key: ValueKey(key),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onTertiaryContainer),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: height * SharedConstants.generalPadding,
                ),
                child: Icon(
                  icondata,
                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                ),
              ),
            ],
          )),
    );
  }

  Widget buildDeviceList(BuildContext context) {
    return FutureBuilder(
      future: getDeviceList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return DropdownButton<String>(
            items: snapshot.data!.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              );
            }).toList(),
            onChanged: (String? value) {
              ref.read(selectedDevice.notifier).update((state) => value!);
              debugPrint('Selected Device: $value');
              value = ref.read(selectedDevice);
            },
            value: device,
          );
        }
      },
    );
  }

  Widget buildTaskList(BuildContext context) {
    return FutureBuilder(
      future: getTaskInfoWithDeviceId(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Column(
            children: [
              snapshot.data!.map<ListTile>(
                title: Text(
                  snapshot.data['name'],
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                subtitle: Text(
                  snapshot.data['frequency'],
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      snapshot.data['status'],
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    IconButton(
                      onPressed: () {
                        snapshot.data['status'] == 'active'
                            ? snapshot.data['status'] = 'passive'
                            : snapshot.data['status'] = 'active';
                      },
                      icon: Icon(
                        Icons.edit,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
