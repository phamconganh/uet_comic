import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:uet_comic/src/core/services/local.dart';
// import 'package:uet_comic/src/core/services/user_data.dart';
// import 'package:uet_comic/src/core/view_models/views/account.dart';

class LikeDao extends ChangeNotifier {
  static const String LIKE_RECORD = 'likes';
  Future<Database> get _db async => await LocalService.instance.database;
  final _likesRecord = StoreRef.main().record(LIKE_RECORD);

  // final AccountModel accountModel;

  // LikeDao({this.accountModel}) {
  //   init();
  // }

  LikeDao() {
    init();
  }

  List<String> _idLikedComics = [];
  List<String> get idLikedComics => _idLikedComics;
  void setIdLikedComics(List<String> idLikedComics) {
    _idLikedComics = idLikedComics;
    notifyListeners();
    rewrite();
  }

  Future init() async {
    try {
      final _idLikedComicsTmp = await _likesRecord.get(await _db);
      if (_idLikedComicsTmp != null) {
        // do _idLikedComicsTmp la read-only
        _idLikedComics = List.from(_idLikedComicsTmp);
        print("_idLikedComics: $_idLikedComics");
        notifyListeners();
      }
    } catch (e) {
      print("Error in init LikeDao : ${e.toString()}");
    }
  }

  bool add(String id) {
    if (!_idLikedComics.contains(id)) {
      _idLikedComics.add(id);
      notifyListeners();
      rewrite();
      return true;
      // if(accountModel.isLogined) {
      //   UserDataService.instance.addLikedComic(accountModel.currentUser.uid, id);
      // }
    }
    return false;
  }

  bool remove(String id) {
    int index = _idLikedComics.indexOf(id);
    if (index > -1) {
      _idLikedComics.removeAt(index);
      notifyListeners();
      rewrite();
      return true;
      // if(accountModel.isLogined) {
      //   UserDataService.instance.removeLikedComic(accountModel.currentUser.uid, id);
      // }
    }
    return false;
  }

  Future rewrite() async {
    await _likesRecord.put(await _db, _idLikedComics);
  }

  void removeAll() async {
    _idLikedComics = [];
    notifyListeners();
    _likesRecord.delete(await _db);
  }
}
