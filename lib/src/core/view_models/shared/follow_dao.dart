import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:uet_comic/src/core/services/local.dart';
import 'package:uet_comic/src/core/services/user_data.dart';
import 'package:uet_comic/src/core/view_models/views/account.dart';

class FollowDao extends ChangeNotifier {
  static const String FOLLOW_RECORD = 'follows';
  Future<Database> get _db async => await LocalService.instance.database;
  final _followsRecord = StoreRef.main().record(FOLLOW_RECORD);

  final AccountModel accountModel;

  FollowDao({this.accountModel}) {
    init();
  }

  List<String> _idFollowedComics = [];
  List<String> get idFollowedComics => _idFollowedComics;
  void setIdFollowedComics(List<String> idFollowedComics) {
    _idFollowedComics = idFollowedComics;
    notifyListeners();
    rewrite();
  }

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
      if(accountModel.isLogined) {
        UserDataService.instance.addFollowedComic(accountModel.currentUser.uid, id);
      }
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
      if(accountModel.isLogined) {
        UserDataService.instance.removeFollowedComic(accountModel.currentUser.uid, id);
      }
    }
  }

  Future rewrite() async {
    await _followsRecord.put(await _db, _idFollowedComics);
  }

  void removeAll() async {
    _idFollowedComics = [];
    notifyListeners();
    _followsRecord.delete(await _db);
  }
}
