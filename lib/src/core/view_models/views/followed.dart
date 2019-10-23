import 'package:uet_comic/src/core/models/comic_cover.dart';
import 'package:uet_comic/src/core/view_models/base.dart';

class FollowedPageModel extends BaseModel {

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
          imageLink:
              "http://i.mangaqq.com/ebook/190x247/musashi_1552552399.jpg?thang=t6544651",
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
