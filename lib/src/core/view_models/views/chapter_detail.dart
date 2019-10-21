import 'package:uet_comic/src/core/models/chapter.dart';
import 'package:uet_comic/src/core/view_models/base.dart';

class ChapterDetailPageModel extends BaseModel {
  Chapter _chapter;
  Chapter get chapter => _chapter;

  Future fetchChapterDetail(String idChapter) async {
    setBusy(true);
    _chapter = Chapter(
      id: "1",
      idComic: "1",
      name: "1",
      lastUpdate: DateTime.now(),
      images: [
        "http://i.mangaqq.com/ebook/190x247/musashi_1552552399.jpg?thang=t6544651",
        "http://i.mangaqq.com/ebook/190x247/musashi_1552552399.jpg?thang=t6544651",
        "http://i.mangaqq.com/ebook/190x247/musashi_1552552399.jpg?thang=t6544651",
        "http://i.mangaqq.com/ebook/190x247/musashi_1552552399.jpg?thang=t6544651",
        "http://i.mangaqq.com/ebook/190x247/musashi_1552552399.jpg?thang=t6544651",
        "http://i.mangaqq.com/ebook/190x247/musashi_1552552399.jpg?thang=t6544651",
        "http://i.mangaqq.com/ebook/190x247/musashi_1552552399.jpg?thang=t6544651",
        "http://i.mangaqq.com/ebook/190x247/musashi_1552552399.jpg?thang=t6544651",
        "http://i.mangaqq.com/ebook/190x247/musashi_1552552399.jpg?thang=t6544651",
        "http://i.mangaqq.com/ebook/190x247/musashi_1552552399.jpg?thang=t6544651",
        "http://i.mangaqq.com/ebook/190x247/musashi_1552552399.jpg?thang=t6544651",
        "http://i.mangaqq.com/ebook/190x247/musashi_1552552399.jpg?thang=t6544651",
        "http://i.mangaqq.com/ebook/190x247/musashi_1552552399.jpg?thang=t6544651",
        "http://i.mangaqq.com/ebook/190x247/musashi_1552552399.jpg?thang=t6544651",
        "http://i.mangaqq.com/ebook/190x247/musashi_1552552399.jpg?thang=t6544651",
      ],
    );
    setBusy(false);
  }
}
