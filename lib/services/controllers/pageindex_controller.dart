import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../provider/all_provider.dart';

class PageIndexController {
  WidgetRef ref;
  PageIndexController({required this.ref});

  int _index = 0;
  int getIndex() {
    _index = ref.watch(pageIndexProvider) ?? 0;
    return _index;
  }

  void setIndex(int index) {
    _index = index;
    ref.read(pageIndexProvider.notifier).state = index;
  }
}
