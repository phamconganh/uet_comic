import 'package:flutter/foundation.dart';

class ComicInfoModel extends ChangeNotifier {
  bool _isHide = true;
  bool get isHide => _isHide;
  void setHide(bool value) {
    if (value != _isHide) {
      _isHide = value;
      notifyListeners();
    }
  }
}
