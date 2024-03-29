import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wc_project/services/provider/all_provider.dart';

import '../../shared/constant_shared.dart';

class DeviceController {
  final WidgetRef ref;
  DeviceController({
    required this.ref,
  });
  Future<bool> getDeviceSetupStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDeviceSaved =
        prefs.getBool(SharedConstants.preferanceDeviceSavedControllText) ??
            false;
    int isDeviceSavedInt = isDeviceSaved ? 1 : 0;
    ref
        .read(isDeviceSavedProvider.notifier)
        .update((state) => isDeviceSavedInt);
    return isDeviceSaved;
  }
}
