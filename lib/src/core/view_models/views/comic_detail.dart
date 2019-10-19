import 'package:uet_comic/src/core/models/comic_cover.dart';
import 'package:uet_comic/src/core/models/comic_detail.dart';
import 'package:uet_comic/src/core/view_models/base.dart';

class ComicDetailPageModel extends BaseModel {
  ComicDetail _comicDetail;
  ComicDetail get comicDetail => _comicDetail;

  List<ComicCover> _sameComic = [];
  List<ComicCover> get sameComic => _sameComic;

  Future fetchComicDetail(String idComic, {bool isSetBusy = true}) async {
    if (isSetBusy) setBusy(true);
    _comicDetail = ComicDetail(
      name: "Test asdasd asdasdasd adasdasd asdasdad adasdasda",
      lastUpdate: DateTime.now(),
      lastChapter: 1,
      imageLink:
          "http://i.mangaqq.com/ebook/190x247/musashi_1552552399.jpg?thang=t6544651",
    );
    if (isSetBusy) setBusy(false);
  }

  Future fetchSameComics() async {
    setBusy(true);
    for (var i = 0; i < 6; i++) {
      _sameComic.add(
        ComicCover(
          id: (i+30).toString(),
          name: "Test asdasd asdasdasd adasdasd asdasdad adasdasda",
          lastUpdate: DateTime.now(),
          lastChapter: 1,
          imageLink:
              "http://i.mangaqq.com/ebook/190x247/musashi_1552552399.jpg?thang=t6544651",
          // "http://3.bp.blogspot.com/-LHURB4jzEx4/Xalm8fUkWUI/AAAAAAAAAk8/IcOExDRGY7c1um5Xi0ePNSZs6Lb0rmRCgCKgBGAsYHg/s0/02.jpg?imgmax=0",
        ),
      );
    }
    setBusy(false);
  }
}
