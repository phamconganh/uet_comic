import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:uet_comic/src/core/models/comic.dart';
import 'package:uet_comic/src/core/services/local.dart';

class ComicDao extends ChangeNotifier {
  static const String COMIC_STORE_NAME = 'comics';
  final _comicsStore = intMapStoreFactory.store(COMIC_STORE_NAME);
  Future<Database> get _db async => await LocalService.instance.database;

  ComicDao() {
    init();
  }

  List<Comic> _downloadedComics = [];
  List<Comic> get downloadedComics => _downloadedComics;

  Future init() async {
    try {
      final _downloadedComicsTmp = await _comicsStore.find(await _db);
      if (_downloadedComicsTmp != null) {
        // do _downloadedComicsTmp la read-only
        _downloadedComics =
            _downloadedComicsTmp.map((e) => Comic.fromMap(e.value)).toList();
        print("_downloadedComics: $_downloadedComics");
        notifyListeners();
      }
    } catch (e) {
      print("Error in init ComicDao : ${e.toString()}");
    }
  }

  Future<int> add(Comic comic) async {
    print("Before add download: " + _downloadedComics.toString());
    if (_downloadedComics.indexWhere((e) => e.id == comic.id) == -1) {
      _downloadedComics.add(comic);
      print("After add download: " + _downloadedComics.toString());
      int key = await _comicsStore.add(await _db, comic.toMap());
      notifyListeners();
      return key;
    }
    return -1;
  }

  void unProcess(int key, String id) async {
    if (key != null && key > -1) {
      var record = _comicsStore.record(key);
      record.update(await _db, {"isInProcess": false});
    }
    int index = _downloadedComics.indexWhere((e) => e.id == id);
    if (index > -1) {
      _downloadedComics[index].isInProcess = false;
      notifyListeners();
    }
  }

  void remove(String id) async {
    int index = _downloadedComics.indexWhere((e) => e.id == id);
    print("Before remove download: " + _downloadedComics.toString());
    if (index > -1) {
      _downloadedComics.removeAt(index);
      print("After remove download: " + _downloadedComics.toString());
      notifyListeners();
      _comicsStore.delete(
        await _db,
        finder: Finder(
          filter: Filter.equals('id', id),
          limit: 1,
        ),
      );
    }
  }
}
