import 'package:flutter/foundation.dart';
import 'package:uet_comic/src/core/constants/app_contstants.dart';
import 'package:uet_comic/src/core/models/comic_cover.dart';
import 'package:uet_comic/src/core/models/type.dart' as uet_comic;
import 'package:uet_comic/src/core/services/comic.dart';
import 'package:uet_comic/src/core/services/type.dart';

class FilterPageModel extends ChangeNotifier {
  FilterPageModel() {
    init();
  }

  bool _busy = false;
  bool get busy => _busy;
  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  List<uet_comic.Type> _types = [];
  List<uet_comic.Type> get types => _types;
  void setTypes(List<uet_comic.Type> types) {
    _types = types;
  }

  // uet_comic.Type _type;
  // uet_comic.Type get type => _type;
  // void setType(uet_comic.Type value) {
  //   _type = value;
  //   notifyListeners();
  // }

  String _idType;
  String get idType => _idType;
  void setIdType(String value) {
    _idType = value;
    notifyListeners();
  }

  int _state;
  int get state => _state;
  void setState(int value) {
    _state = value;
    notifyListeners();
  }

  int _gender;
  int get gender => _gender;
  void setGender(int value) {
    _gender = value;
    notifyListeners();
  }

  Age _age;
  Age get age => _age;
  void setAge(Age value) {
    _age = value;
    notifyListeners();
  }

  Sort _sort;
  Sort get sort => _sort;
  void setSort(Sort value) {
    _sort = value;
    notifyListeners();
  }

  void init() async {
    setBusy(true);
    _types = await TypeService.instance.fetchTypes();
    setBusy(false);
  }

  void clear() {
    _idType = null;
    _state = null;
    _gender = null;
    _age = null;
    _sort = null;
    notifyListeners();
  }

  List<ComicCover> _comicCovers = [];
  List<ComicCover> get comicCovers => _comicCovers;
  Future fetchFilter() async {
    setBusy(true);
    _comicCovers = await ComicService.instance.fetchComicCoversByFilter(idType, state, gender, age, sort);
    setBusy(false);
  }
}
