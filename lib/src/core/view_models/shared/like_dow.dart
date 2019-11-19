import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:uet_comic/src/core/services/local.dart';

class LikeDao extends ChangeNotifier {
  static const String LIKE_RECORD = 'likes';
  // final _followStore = intMapStoreFactory.store(LIKE_STORE_NAME);
  Future<Database> get _db async => await LocalService.instance.database;
  final _likesRecord = StoreRef.main().record(LIKE_RECORD);

  LikeDao() {
    init();
  }

  List<String> _idLikedComics = [];
  List<String> get idLikedComics => _idLikedComics;

  Future init() async {
    try {
      final _idLikedComicsTmp = await _likesRecord.get(await _db);
      if(_idLikedComicsTmp != null) {
        // do _idLikedComicsTmp la read-only
        _idLikedComics = List.from(_idLikedComicsTmp);
        print("_idLikedComics: $_idLikedComics");
        notifyListeners();
      }
    } catch (e) {
      print("Error in init LikeDao : ${e.toString()}");
    }
  }

  void add(String id) {
    if (!_idLikedComics.contains(id)) {
      _idLikedComics.add(id);
      notifyListeners();
      rewrite();
    }
  }

  void remove(String id) {
    int index = _idLikedComics.indexOf(id);
    if (index > -1) {
      _idLikedComics.removeAt(index);
      notifyListeners();
      rewrite();
    }
  }

  Future rewrite() async {
    await _likesRecord.put(await _db, _idLikedComics);
  }
}
