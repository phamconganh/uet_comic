import 'package:flutter/foundation.dart';
import 'package:uet_comic/src/core/models/comic_cover.dart';

class DownloadedPageModel extends ChangeNotifier {
  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  List<ComicCover> _downloadedComics = [];
  List<ComicCover> get downloadedComics => _downloadedComics;

  Future fetchDownloadedComics() async {
    for (var i = 0; i < 5; i++) {
      _downloadedComics.add(
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

  void deleteComic(int index) {
    _downloadedComics.removeAt(index);
    notifyListeners();
  }

  void updateComic(int index) {
    // _downloadedComic.removeAt(index);
    // notifyListeners();
  }
}
