import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:uet_comic/src/core/services/local.dart';

class FollowDao extends ChangeNotifier {
  static const String FOLLOW_RECORD = 'follows';
  // final _followStore = intMapStoreFactory.store(FOLLOW_STORE_NAME);
  Future<Database> get _db async => await LocalService.instance.database;
  final _followsRecord = StoreRef.main().record(FOLLOW_RECORD);

  FollowDao() {
    init();
  }

  List<String> _idFollowedComics = [];
  List<String> get idFollowedComics => _idFollowedComics;

  Future init() async {
    try {
      final _idFollowedComicsTmp = await _followsRecord.get(await _db);
      if(_idFollowedComicsTmp != null) {
        // do _idFollowedComicsTmp la read-only
        _idFollowedComics = List.from(_idFollowedComicsTmp);
        print("_idFollowedComics: $_idFollowedComics");
        notifyListeners();
      }
    } catch (e) {
      print("Error in init FollowDao : ${e.toString()}");
    }
  }

  void add(String id) {
    print("Before add follow: " + _idFollowedComics.toString());
    if (!_idFollowedComics.contains(id)) {
      _idFollowedComics.add(id);
      print("After add follow: " + _idFollowedComics.toString());
      notifyListeners();
      rewrite();
    }
  }

  void remove(String id) {
    int index = _idFollowedComics.indexOf(id);
    print("Before remove follow: " + _idFollowedComics.toString());
    if (index > -1) {
      _idFollowedComics.removeAt(index);
      print("After remove follow: " + _idFollowedComics.toString());
      notifyListeners();
      rewrite();
    }
  }

  Future rewrite() async {
    await _followsRecord.put(await _db, _idFollowedComics);
  }
}
