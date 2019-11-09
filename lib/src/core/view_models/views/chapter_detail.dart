import 'package:flutter/foundation.dart';
import 'package:uet_comic/src/core/models/chapter.dart';

class ChapterDetailPageModel extends ChangeNotifier {
  List<Chapter> _chapters = [];
  List<Chapter> get chapters => _chapters;
  int _index = 0;
  int get index => _index;
  Chapter get chapter => _chapters != null && _index >= 0 && _index < _chapters.length ? _chapters[_index] : null;
  void setChaptersWithIndex(int index, List<Chapter> chapters) {
    _index = index;
    _chapters = chapters;
    notifyListeners();
  }
  void setIndex(int index) {
    index >=0 ? _index = index : _index = 0;
    notifyListeners();
  }

  bool get isEnd => _chapters != null && _index == _chapters.length - 1;
  bool get isStart => _chapters != null && _index == 0;
}
