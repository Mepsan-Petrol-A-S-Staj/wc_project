import 'package:riverpod/riverpod.dart';

final firstAppProvider = StateProvider<bool>((ref) => false);
final pageIndexProvider = StateProvider<int>((ref) => 4);
final rateProvider = StateProvider<int>((ref) => 1);
final deviceIpAdressProvider = StateProvider<String>((ref) => '');
final selectedDevice = StateProvider<String>((ref) => '');
