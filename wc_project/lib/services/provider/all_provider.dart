import 'package:riverpod/riverpod.dart';

// final firstAppProvider = StateProvider<bool>((ref) => false); // First app control
final isDeviceSavedProvider =
    StateProvider<int>((ref) => 0); // Device saved control
final pageIndexProvider = StateProvider<int>((ref) => 0); // Page index control
final ipAdressProvicer =
    StateProvider<String>((ref) => ""); // Device ip adress control


/// TODO: Look at the following code snippet and see if it can be refactored
final rateProvider = StateProvider<int>((ref) => 1);
final deviceIpAdressProvider = StateProvider<String>((ref) => '');
final selectedDevice = StateProvider<String>((ref) => 'device1');
final afkTimeCounter = StateProvider<int>((ref) => 0);
final tokenProvider = StateProvider<String>((ref) => '');
final userIdProvider = StateProvider<int>((ref) => 0);
final providerSelectedFloor = StateProvider<String>((ref) => 'emptyfloor');
final isLoginedProvider = StateProvider<bool>((ref) => false);
final screenTypeProvider = StateProvider<int>((ref) => 0);
final adminPageWidgetKey = StateProvider<String>((ref) => 'main');

final adminPageSelectedDevice = StateProvider<String>((ref) => '');
final adminPageSelectedTask = StateProvider<String>((ref) => '');
