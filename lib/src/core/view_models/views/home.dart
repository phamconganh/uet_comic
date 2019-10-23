import 'package:uet_comic/src/core/models/comic_cover.dart';
import 'package:uet_comic/src/core/view_models/base.dart';

class HomePageModel extends BaseModel {
  List<ComicCover> covers = [];
  HomePageModel() {
    for (var i = 0; i < 30; i++) {
      covers.add(
        ComicCover(
          id: i.toString(),
          name: "Test asdasd asdasdasd adasdasd asdasdad adasdasda",
          lastUpdate: DateTime.now(),
          lastChapter: "1",
          imageLink:
              "http://i.mangaqq.com/ebook/190x247/musashi_1552552399.jpg?thang=t6544651",
          // "http://3.bp.blogspot.com/-LHURB4jzEx4/Xalm8fUkWUI/AAAAAAAAAk8/IcOExDRGY7c1um5Xi0ePNSZs6Lb0rmRCgCKgBGAsYHg/s0/02.jpg?imgmax=0",
        ),
      );
    }
  }

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
    print(1);
    _newComicCovers = covers.sublist(0, 10);
    setBusyNewComicCovers(false);
  }

  Future fetchMaleComicCovers() async {
    setBusyMaleComicCovers(true);
    _maleComicCovers = covers.sublist(10, 20);
    setBusyMaleComicCovers(false);
  }

  Future fetchFemaleComicCovers() async {
    setBusyFemaleComicCovers(true);
    _femaleComicCovers = covers.sublist(20, 30);
    setBusyFemaleComicCovers(false);
  }
}