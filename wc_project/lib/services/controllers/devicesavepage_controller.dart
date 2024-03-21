import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../provider/all_provider.dart';

class DeviceSavePageController {
  final WidgetRef ref;
  DeviceSavePageController({
    required this.ref,
  });

  String getSelectedValue(String value) {
    switch (value) {
      case "Teras":
        floorProviderService('terrasfloor');
        return 'terrasfloor';
      case "2":
        floorProviderService('secondfloor');
        return 'secondfloor';
      case "1":
        floorProviderService('firstfloor');
        return 'firstfloor';
      case "Zemin":
        floorProviderService('groundfloor');
        return 'groundfloor';
      case "empty":
        floorProviderService('emptyfloor');
        return 'emptyfloor';
      default:
        floorProviderService('emptyfloor');
        return 'emptyfloor';
    }
  }

  String getFloorInt(String value) {
    switch (value) {
      case "terrasfloor":
        return 'Teras';
      case "secondfloor":
        return '2';
      case "firstfloor":
        return '1';
      case "groundfloor":
        return 'Zemin';
      case "emptyfloor":
        return 'empty';
      default:
        return 'empty';
    }
  }

  void floorProviderService(String value) {
    ref.read(providerSelectedFloor.notifier).update((state) => value);
  }
}
