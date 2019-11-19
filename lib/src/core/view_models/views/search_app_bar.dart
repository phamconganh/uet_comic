import 'package:flutter/foundation.dart';
import 'package:uet_comic/src/core/models/comic_cover.dart';
import 'package:uet_comic/src/core/services/comic.dart';

class SearchAppBarModel extends ChangeNotifier {
  bool _busy = false;
  bool get busy => _busy;
  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  List<ComicCover> _comicCovers = [];
  List<ComicCover> get comicCovers => _comicCovers;

  Future fetchComicCoversByName(String name) async {
    setBusy(true);
    _comicCovers = await ComicService.instance.fetchComicCoversByName(name);
    setBusy(false);
  }
}
