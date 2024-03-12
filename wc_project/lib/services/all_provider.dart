import 'package:riverpod/riverpod.dart';

final firstAppProvider = StateProvider<bool>((ref) => false);
final pageIndexProvider = StateProvider<int>((ref) => 0);
final rateProvider = StateProvider<int>((ref) => 1);
