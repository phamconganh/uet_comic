import 'package:uet_comic/src/core/models/comic_cover.dart';
import 'package:uet_comic/src/core/view_models/base.dart';

class DownloadedPageModel extends BaseModel {

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
          imageLink:
              "http://i.mangaqq.com/ebook/190x247/musashi_1552552399.jpg?thang=t6544651",
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
