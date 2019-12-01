import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:uet_comic/src/core/services/local.dart';
// import 'package:uet_comic/src/core/services/user_data.dart';
// import 'package:uet_comic/src/core/view_models/views/account.dart';

class SearchDao extends ChangeNotifier {
  static const String SEARCHES_RECORD = 'searches';
  Future<Database> get _db async => await LocalService.instance.database;
  final _searchesRecord = StoreRef.main().record(SEARCHES_RECORD);

  // final AccountModel accountModel;

  // SearchDao({this.accountModel}) {
  //   init();
  // }

  SearchDao() {
    init();
  }

  List<String> _nameSearchedComics = [];
  List<String> get nameSearchedComics => _nameSearchedComics;
  void setNameSearchedComics(List<String> nameSearchedComics) {
    _nameSearchedComics = nameSearchedComics;
    notifyListeners();
    rewrite();
  }

  Future init() async {
    try {
      final _nameSearchedComicsTmp = await _searchesRecord.get(await _db);
      print(_nameSearchedComicsTmp);
      if (_nameSearchedComicsTmp != null) {
        // do _nameSearchedComicsTmp la read-only
        _nameSearchedComics = List.from(_nameSearchedComicsTmp);
        print("_nameSearchedComics: $_nameSearchedComics");
        notifyListeners();
      }
    } catch (e) {
      print("Error in init SearchDao : ${e.toString()}");
    }
  }

  bool add(String name) {
    print("Before add SEARCH: " + _nameSearchedComics.toString());
    if (!_nameSearchedComics.contains(name)) {
      _nameSearchedComics.insert(0, name);
      print("After add SEARCH: " + _nameSearchedComics.toString());
      notifyListeners();
      rewrite();
      return true;
      // if (accountModel.isLogined) {
      //   UserDataService.instance
      //       .addSearchedComic(accountModel.currentUser.uid, name);
      // }
    }
    return false;
  }

  bool remove(String name) {
    int index = _nameSearchedComics.indexOf(name);
    print("Before remove SEARCH: " + _nameSearchedComics.toString());
    if (index > -1) {
      _nameSearchedComics.removeAt(index);
      print("After remove SEARCH: " + _nameSearchedComics.toString());
      notifyListeners();
      rewrite();
      return true;
      // if (accountModel.isLogined) {
      //   UserDataService.instance
      //       .removeSearchedComic(accountModel.currentUser.uid, name);
      // }
    }
    return false;
  }

  Future rewrite() async {
    await _searchesRecord.put(await _db, _nameSearchedComics);
  }

  void removeAll() async {
    _nameSearchedComics = [];
    notifyListeners();
    _searchesRecord.delete(await _db);
  }
}
