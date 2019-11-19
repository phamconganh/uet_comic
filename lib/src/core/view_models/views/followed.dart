import 'package:flutter/foundation.dart';
import 'package:uet_comic/src/core/models/comic_cover.dart';
import 'package:uet_comic/src/core/services/comic.dart';
import 'package:uet_comic/src/core/view_models/shared/follow_dao.dart';

class FollowedPageModel extends ChangeNotifier {
  final FollowDao followDao;

  FollowedPageModel({@required this.followDao}) : assert(followDao != null) {
    fetchFollowedComics();
  }
  ComicService comicService = ComicService();

  bool _busy = false;
  bool get busy => _busy;
  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  Future fetchFollowedComics() async {
    setBusy(true);
    _followedComics = await comicService.fetchFollowedComicCovers(followDao.idFollowedComics);
    setBusy(false);
  }

  List<ComicCover> _followedComics = [];
  List<ComicCover> get followedComics => _followedComics;

  // Future fetchFollowedComics() async {
  //   for (var i = 0; i < 5; i++) {
  //     _followedComics.add(
  //       ComicCover(
  //         id: i.toString(),
  //         name: "Test asdasd asdasdasd adasdasd asdasdad adasdasda",
  //         lastUpdate: DateTime.now(),
  //         lastChapter: "1",
  //         imageLink: "https://i.imgur.com/d9EEHCS.jpg",
  //       ),
  //     );
  //   }
  //   setBusy(false);
  // }

  void unFollowComic(int index) {
    _followedComics.removeAt(index);
    notifyListeners();
  }
}
