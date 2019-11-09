import 'package:flutter/foundation.dart';
import 'package:uet_comic/src/core/models/comic_cover.dart';

class FollowedPageModel extends ChangeNotifier {
  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  List<ComicCover> _followedComics = [];
  List<ComicCover> get followedComics => _followedComics;

  Future fetchFollowedComics() async {
    for (var i = 0; i < 5; i++) {
      _followedComics.add(
        ComicCover(
          id: i.toString(),
          name: "Test asdasd asdasdasd adasdasd asdasdad adasdasda",
          lastUpdate: DateTime.now(),
          lastChapter: "1",
          imageLink: "https://i.imgur.com/d9EEHCS.jpg",
        ),
      );
    }
    setBusy(false);
  }

  void unFollowComic(int index) {
    _followedComics.removeAt(index);
    notifyListeners();
  }
}
