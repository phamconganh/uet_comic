import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BasePageModel extends ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  void setSelectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }

  final pageController = PageController();

  void slideToPage(int value) {
    if (value != _selectedIndex) {
      _selectedIndex = value;
      pageController.animateToPage(value,
          duration: Duration(milliseconds: 300),
          curve: Curves.ease);
      notifyListeners();
    }
  }
}
