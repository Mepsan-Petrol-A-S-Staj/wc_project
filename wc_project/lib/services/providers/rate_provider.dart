import 'package:flutter/material.dart';

class RateProvider with ChangeNotifier {
  int _index = 1;
  int get getIndex => _index;

  void setIndex(int setIndex) {
    _index = setIndex;
    notifyListeners();
  }
}
