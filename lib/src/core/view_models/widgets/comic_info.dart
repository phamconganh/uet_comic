import 'package:uet_comic/src/core/view_models/base.dart';

class ComicInfoModel extends BaseModel {
  bool _isHide = true;
  bool get isHide => _isHide;
  void setHide(bool value) {
    if (value != _isHide) {
      _isHide = value;
      notifyListeners();
    }
  }
}
