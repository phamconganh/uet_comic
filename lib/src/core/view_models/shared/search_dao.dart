import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:uet_comic/src/core/services/local.dart';

class SearchDao extends ChangeNotifier {
  static const String SEARCHES_RECORD = 'searches';
  Future<Database> get _db async => await LocalService.instance.database;
  final _searchesRecord = StoreRef.main().record(SEARCHES_RECORD);

  SearchDao() {
    init();
  }

  List<String> _nameSearchedComics = [];
  List<String> get nameSearchedComics => _nameSearchedComics;

  Future init() async {
    try {
      final _nameSearchedComicsTmp = await _searchesRecord.get(await _db);
      print(_nameSearchedComicsTmp);
      if(_nameSearchedComicsTmp != null) {
        // do _nameSearchedComicsTmp la read-only
        _nameSearchedComics = List.from(_nameSearchedComicsTmp);
        print("_nameSearchedComics: $_nameSearchedComics");
        notifyListeners();
      }
    } catch (e) {
      print("Error in init SearchDao : ${e.toString()}");
    }
  }

  void add(String name) {
    print("Before add SEARCH: " + _nameSearchedComics.toString());
    if (!_nameSearchedComics.contains(name)) {
      _nameSearchedComics.insert(0, name);
      print("After add SEARCH: " + _nameSearchedComics.toString());
      notifyListeners();
      rewrite();
    }
  }

  void remove(String name) {
    int index = _nameSearchedComics.indexOf(name);
    print("Before remove SEARCH: " + _nameSearchedComics.toString());
    if (index > -1) {
      _nameSearchedComics.removeAt(index);
      print("After remove SEARCH: " + _nameSearchedComics.toString());
      notifyListeners();
      rewrite();
    }
  }

  Future rewrite() async {
    await _searchesRecord.put(await _db, _nameSearchedComics);
  }
}
