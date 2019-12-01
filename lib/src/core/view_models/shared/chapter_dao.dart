import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:uet_comic/src/core/models/chapter.dart';
import 'package:uet_comic/src/core/services/local.dart';

class ChapterDao extends ChangeNotifier {
  static const String ComicDao = 'chapters';
  final _chaptersStore = intMapStoreFactory.store(ComicDao);
  Future<Database> get _db async => await LocalService.instance.database;

  Future<List<Chapter>> getChaptersByComicId(String id) async {
    final _downloadedChaptersTmp = await _chaptersStore.find(
      await _db,
      finder: Finder(
        filter: Filter.equals("idComic", id),
        sortOrders: [SortOrder('index', false)],
      ),
    );
    if (_downloadedChaptersTmp.isNotEmpty) {
      return _downloadedChaptersTmp
          .map((e) => Chapter.fromMap(e.value))
          .toList();
    }
    return [];
  }

  void add(Chapter chapter) async {
    remove(chapter);
    _chaptersStore.add(await _db, chapter.toMap());
  }

  void remove(Chapter chapter) async {
    _chaptersStore.delete(
      await _db,
      finder: Finder(
        filter: Filter.equals("id", chapter.id),
      ),
    );
  }

  void removeByIdComic(String id) async {
    _chaptersStore.delete(
      await _db,
      finder: Finder(
        filter: Filter.equals("idComic", id),
      ),
    );
  }

  void removeAll() async {
    _chaptersStore.delete(await _db);
  }
}
