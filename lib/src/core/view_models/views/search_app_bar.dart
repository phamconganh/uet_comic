import 'package:flutter/foundation.dart';
import 'package:uet_comic/src/core/models/comic_cover.dart';
import 'package:uet_comic/src/core/services/comic.dart';

class SearchAppBarModel extends ChangeNotifier {

  ComicService comicService = ComicService();

  bool _busy = false;
  bool get busy => _busy;
  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  Future searchComics(String name) async {
    setBusy(true);
    _comicCovers = await comicService.fetchComicCoversByName(name);
    print(_comicCovers);
    setBusy(false);
  }

  List<ComicCover> _comicCovers = [];
  List<ComicCover> get comicCovers => _comicCovers;
}
