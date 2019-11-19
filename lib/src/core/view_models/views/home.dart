import 'package:flutter/widgets.dart';
import 'package:uet_comic/src/core/models/comic_cover.dart';
import 'package:uet_comic/src/core/services/comic.dart';

class HomePageModel extends ChangeNotifier {
  HomePageModel() {
    onLoadData();
  }

  Future<void> onLoadData() async {
    print("onLoadData");
    // fetchNewComicCovers();
    // fetchMaleComicCovers();
    // fetchFemaleComicCovers();
    return;
  }

  List<ComicCover> covers = [];
  ComicService comicService = ComicService();

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

  Future fetchNewComicCovers() async {
    setBusyNewComicCovers(true);
    try {
      _newComicCovers = await comicService.fetchNewComicCovers();
    } catch (e) {
      print("Loi o _newComicCovers: ${e.runtimeType}");
    }
    setBusyNewComicCovers(false);
  }

  Future fetchMaleComicCovers() async {
    setBusyMaleComicCovers(true);
    try {
      _maleComicCovers = await comicService.fetchMaleComicCovers();
    } catch (e) {
      print("Loi o _maleComicCovers: ${e.runtimeType}");
    }
    setBusyMaleComicCovers(false);
  }

  Future fetchFemaleComicCovers() async {
    setBusyFemaleComicCovers(true);
    try {
      _femaleComicCovers = await comicService.fetchFemaleComicCovers();
    } catch (e) {
      print("Loi o _femaleComicCovers: ${e.runtimeType}");
    }
    setBusyFemaleComicCovers(false);
  }
}
