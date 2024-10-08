import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wc_project/widgets/admin_page/adminanswer_widget.dart';
import 'package:wc_project/widgets/admin_page/admindevice_widget.dart';
import 'package:wc_project/widgets/admin_page/adminuser_widget.dart';
import '../../../models/device_model.dart';
import '../../../pages/devicesave_page.dart';
import '../../../shared/constant_shared.dart';
import '../../../widgets/admin_page/adminpagedeviceselect_widget.dart';
import '../../../widgets/admin_page/adminpagemain_widget.dart';
import '../../../widgets/admin_page/admintask_widget.dart';
import '../../../widgets/admin_page/admintaskedit_widget.dart';
import '../../apis/device_service.dart';
import '../../apis/task-devicecon_service.dart';
import '../../provider/all_provider.dart';
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
    String token = ref.watch(tokenProvider);
    debugPrint('Token Degeri: $token');
    List<String> deviceList = [];
    try {
      final List<Device> devices =
          await DeviceService(ref: ref).getAllDevice(token);
      deviceList = devices.map((device) => device.deviceName).toList();
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

  Future<bool> getDeviceSetupStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDeviceSaved =
        prefs.getBool(SharedConstants.preferanceDeviceSavedControllText) ??
            false;

    return isDeviceSaved;
  }

  Future<Widget> adminBuildSecondAppBar(String selectedDeviceValue) async {
    bool isDeviceSaved = await getDeviceSetupStatus();

    if (isDeviceSaved) {
      return AdminPageDeviceSelectWidget(
          width: width, ref: ref, selectedDeviceValue: selectedDeviceValue);
    } else {
      return const DeviceSavePage();
    }
  }

  Future<Widget> adminBuildPage(String widgetKey) async {
    bool isDeviceSaved = await getDeviceSetupStatus();
    if (isDeviceSaved == false) {
      widgetKey = 'savedevice';
    }
    switch (widgetKey) {
      case 'savedevice':
        return const DeviceSavePage();
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
        return AdminTaskWidget(
          ref: ref,
        );
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
      onTap: () async {
        int selectedDeviceId = await getSelectedMachineId();
        if (selectedDeviceId != -1) {
          ref.read(adminPageWidgetKey.notifier).state = key;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please select a device'),
            ),
          );
          // null;
        }
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

  Widget buildDeviceList(BuildContext context, String selectedDeviceValue) {
    void setSelectedDevice(String deviceName) {
      ref.read(selectedDevice.notifier).update((state) => deviceName);
    }

    return FutureBuilder(
      future: getDeviceList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final devices =
              snapshot.data?.cast<String>() ?? []; // Handle empty list
          debugPrint('Devices: $devices');
          if (devices.isEmpty) {
            return const Text('No devices found'); // Show placeholder
          } else {
            return DropdownButton(
              items: [
                for (int i = 0; i < devices.length; i++)
                  DropdownMenuItem(
                    value: devices[i],
                    child: Text(
                      devices[i],
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
              ],
              onChanged: (String? value) {
                setSelectedDevice(value!);
                debugPrint('Selected Device: $value');
              },
              hint: selectedDeviceValue == ''
                  ? const Text('Select Device')
                  : Text(
                      selectedDeviceValue,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
              // Ensure initial value exists
            );
          }
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

  Future<int> getSelectedMachineId() async {
    String selectedDeviceName = ref.read(selectedDevice);
    int selectedDeviceId = await DeviceService(ref: ref)
        .getDeviceIdbyDeviceName(selectedDeviceName);
    debugPrint('Selected Device Id: $selectedDeviceId');
    return selectedDeviceId;
  }

  // Future<List<Map<String,dynamic>>> get
}
