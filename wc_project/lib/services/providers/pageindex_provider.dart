import 'package:flutter/material.dart';

class PageIndexProvider with ChangeNotifier {
  int _index = 0;

  int get getIndex => _index;

  void setIndex(int setIndex) {
    _index = setIndex;
    notifyListeners();
  }
}
