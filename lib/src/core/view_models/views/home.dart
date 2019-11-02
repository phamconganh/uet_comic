import 'package:flutter/widgets.dart';
import 'package:uet_comic/src/core/models/comic_cover.dart';
import 'package:uet_comic/src/core/services/comic.dart';
import 'package:uet_comic/src/core/view_models/base.dart';

class HomePageModel extends BaseModel {
  List<ComicCover> covers = [];
  ComicService comicService;

  HomePageModel({@required this.comicService}): assert(comicService != null);

  bool _isFetchingNewComicCovers = false;
  bool get isFetchingNewComicCovers => _isFetchingNewComicCovers;
  void setBusyNewComicCovers(bool value) {
    _isFetchingNewComicCovers = value;
    notifyListeners();
  }

  List<ComicCover> _newComicCovers = [];
  List<ComicCover> get newComicCovers => _newComicCovers;

  bool _isFetchingMaleComicCovers = false;
  bool get isFetchingMaleComicCovers => _isFetchingMaleComicCovers;
  void setBusyMaleComicCovers(bool value) {
    _isFetchingMaleComicCovers = value;
    notifyListeners();
  }

  List<ComicCover> _maleComicCovers = [];
  List<ComicCover> get maleComicCovers => _maleComicCovers;

  bool _isFetchingFemaleComicCovers = false;
  bool get isFetchingFemaleComicCovers => _isFetchingFemaleComicCovers;
  void setBusyFemaleComicCovers(bool value) {
    _isFetchingFemaleComicCovers = value;
    notifyListeners();
  }

  List<ComicCover> _femaleComicCovers = [];
  List<ComicCover> get femaleComicCovers => _femaleComicCovers;

  Future fetchDatas({bool isSetBusy = true}) async {
    if (isSetBusy) setBusy(true);
    _newComicCovers = covers.sublist(0, 10);
    _maleComicCovers = covers.sublist(10, 20);
    _femaleComicCovers = covers.sublist(20, 30);
    if (isSetBusy) setBusy(false);
  }

  Future fetchNewComicCovers() async {
    setBusyNewComicCovers(true);
    _newComicCovers = await comicService.fetchNewComicCovers();
    setBusyNewComicCovers(false);
  }

  Future fetchMaleComicCovers() async {
    setBusyMaleComicCovers(true);
    _maleComicCovers = await comicService.fetchMaleComicCovers();
    setBusyMaleComicCovers(false);
  }

  Future fetchFemaleComicCovers() async {
    setBusyFemaleComicCovers(true);
    _femaleComicCovers = await comicService.fetchFemaleComicCovers();
    setBusyFemaleComicCovers(false);
  }
}
