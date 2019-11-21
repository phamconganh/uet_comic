import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:uet_comic/src/core/models/chapter.dart';
import 'package:uet_comic/src/core/services/local.dart';

class ChapterDao extends ChangeNotifier {
  static const String ComicDao = 'chapters';
  final _chaptersStore = intMapStoreFactory.store(ComicDao);
  Future<Database> get _db async => await LocalService.instance.database;

  List<Chapter> _downloadedChapters = [];
  List<Chapter> get downloadedChapters => _downloadedChapters;

  Future getChaptersByComicId(String id) async {
    final _downloadedChaptersTmp = await _chaptersStore.find(
      await _db,
      finder: Finder(
        filter: Filter.equals("idComic", id),
        sortOrders: [SortOrder('index', false)],
      ),
    );
    if (_downloadedChaptersTmp != null) {
      // do _downloadedChaptersTmp la read-only
      _downloadedChapters =
          _downloadedChaptersTmp.map((e) => Chapter.fromMap(e.value)).toList();
      print("_downloadedChapters: $_downloadedChapters");
      notifyListeners();
    }
  }

  // void add(Comic comic) async {
  //   print("Before add download: " + _downloadedChapters.toString());
  //   if (_downloadedChapters.indexWhere((e) => e.id == comic.id) == -1) {
  //     _downloadedChapters.add(comic);
  //     print("After add download: " + _downloadedChapters.toString());
  //     notifyListeners();
  //     _chaptersStore.add(await _db, comic.toMap());
  //   }
  // }

  // void remove(String id) async {
  //   int index = _downloadedChapters.indexWhere((e) => e.id == id);
  //   print("Before remove download: " + _downloadedChapters.toString());
  //   if (index > -1) {
  //     _downloadedChapters.removeAt(index);
  //     print("After remove download: " + _downloadedChapters.toString());
  //     notifyListeners();
  //     _chaptersStore.delete(
  //       await _db,
  //       finder: Finder(
  //         filter: Filter.equals('id', id),
  //         limit: 1,
  //       ),
  //     );
  //   }
  // }
}
