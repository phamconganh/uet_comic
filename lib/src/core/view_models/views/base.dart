import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uet_comic/src/core/view_models/views/account.dart';

class BasePageModel extends ChangeNotifier {

  final AccountModel accountModel;

  BasePageModel({this.accountModel});

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
