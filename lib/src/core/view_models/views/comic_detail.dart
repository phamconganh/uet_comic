import 'package:uet_comic/src/core/models/author.dart';
import 'package:uet_comic/src/core/models/chapter.dart';
import 'package:uet_comic/src/core/models/comic.dart';
import 'package:uet_comic/src/core/models/comic_cover.dart';
import 'package:uet_comic/src/core/view_models/base.dart';
import 'package:uet_comic/src/core/models/type.dart' as uet_comic_type;

class ComicDetailPageModel extends BaseModel {
  bool _isFetchingComicDetail;
  bool get isFetchingComicDetail => _isFetchingComicDetail;
  void setBusyComicDetail(bool value) {
    _isFetchingComicDetail = value;
    notifyListeners();
  }

  Comic _comicDetail;
  Comic get comicDetail => _comicDetail;

  bool _isFetchingChapters;
  bool get isFetchingChapters => _isFetchingChapters;
  void setBusyChapters(bool value) {
    _isFetchingChapters = value;
    notifyListeners();
  }

  List<Chapter> _chapters = [];
  List<Chapter> get chapters => _chapters;

  bool _isFetchingSameComics;
  bool get isFetchingSameComics => _isFetchingSameComics;
  void setBusySameComics(bool value) {
    _isFetchingSameComics = value;
    notifyListeners();
  }

  List<ComicCover> _sameComics = [];
  List<ComicCover> get sameComics => _sameComics;

  Future fetchComicDetail(String idComic) async {
    setBusyComicDetail(true);
    await Future.delayed(Duration(seconds: 5));
    _comicDetail = Comic(
      id: "1",
      name: "Dị Thế Tà Quân",
      state: 0,
      author: Author(id: "1", name: "Chua xac dinh"),
      content:
          "Không giống với một số tác phẩm truyện Tiên Hiệp và Kiếm Hiệp nổi tiếng, nhân vật chính thường có khởi đầu là một yếu nhân nghèo khổ. Nhưng Quân Tà trong tác phẩm Dị Thế Tà Quân của tác giả Phong Lăng Thiên Hạ lại có xuất thân là một sát thủ khét tiếng trong giới hắc đạo, với kỹ năng bắn súng cùng trình độ võ học siêu phàm.Tuy là một sát thủ máu lạnh, giết người vô số nhưng trong thâm tâm hắn vẫn còn lại trái tim con người với lòng cảm thương đối với những người cô thế. Đối với nhiều người, hắn là một kẻ vô cùng hiểm ác nhưng nếu bình tâm nhìn lại sẽ thấy những kẻ mà hắn giết đều là những tên cường hào ác bá, lạm dụng chức quyền hà hiếp người cô thế…Trong một lần tranh đoạt cổ vật với những phe cánh hắc đạo, tính mạng của y gặp phải nguy hiểm tột cùng khi rơi vào vòng vây phục kích. Trong cái rủi lại có cái may, chính lúc này, những món bảo vật huyền bí mà hắn tranh đoạt đã phát tỏa huyền năng đưa hắn trở về thế giới cổ đại, nơi mà pháp luật chỉ mang tính tượng trưng và chân lý chỉ thuộc về kẻ mạnh.Sống trong thế giới nhiễu nhương này, liệu rằng những kỹ năng của một sát thủ có giúp hắn yên ổn tồn tại…?",
      types: [
        uet_comic_type.Type(id: "1", name: "Xuyen khong"),
        uet_comic_type.Type(id: "2", name: "Xuyen khong"),
        uet_comic_type.Type(id: "3", name: "Xuyen khong"),
      ],
      view: 100,
      like: 100,
      follow: 10,
      chapters: [
        Chapter(id: "1", idComic: "1", name: "1", lastUpdate: DateTime.now()),
        Chapter(id: "2", idComic: "1", name: "2", lastUpdate: DateTime.now()),
        Chapter(id: "3", idComic: "1", name: "3", lastUpdate: DateTime.now()),
        Chapter(id: "4", idComic: "1", name: "4", lastUpdate: DateTime.now()),
        Chapter(id: "5", idComic: "1", name: "5", lastUpdate: DateTime.now()),
        Chapter(id: "6", idComic: "1", name: "6", lastUpdate: DateTime.now()),
        Chapter(id: "7", idComic: "1", name: "7", lastUpdate: DateTime.now()),
        Chapter(id: "8", idComic: "1", name: "8", lastUpdate: DateTime.now()),
        Chapter(id: "9", idComic: "1", name: "9", lastUpdate: DateTime.now()),
        Chapter(id: "10", idComic: "1", name: "10", lastUpdate: DateTime.now()),
        Chapter(id: "11", idComic: "1", name: "11", lastUpdate: DateTime.now()),
        Chapter(id: "12", idComic: "1", name: "12", lastUpdate: DateTime.now()),
        Chapter(id: "13", idComic: "1", name: "13", lastUpdate: DateTime.now()),
        Chapter(id: "14", idComic: "1", name: "14", lastUpdate: DateTime.now()),
        Chapter(id: "15", idComic: "1", name: "15", lastUpdate: DateTime.now()),
      ],
      age: 10,
      gender: 1,
      imageLink:
          "https://i.imgur.com/d9EEHCS.jpg",
    );
    setBusyComicDetail(false);
  }

  Future fetchChapters(String idComic) async {

    setBusyChapters(true);
    await Future.delayed(Duration(seconds: 2));

    _chapters = [
      Chapter(id: "1", idComic: "1", name: "1", lastUpdate: DateTime.now()),
      Chapter(id: "2", idComic: "1", name: "2", lastUpdate: DateTime.now()),
      Chapter(id: "3", idComic: "1", name: "3", lastUpdate: DateTime.now()),
    ];
    setBusyChapters(false);
  }

  Future fetchSameComics() async {
    setBusySameComics(true);
    await Future.delayed(Duration(seconds: 7));

    for (var i = 0; i < 6; i++) {
      _sameComics.add(
        ComicCover(
          id: (i + 30).toString(),
          name: "Test asdasd asdasdasd adasdasd asdasdad adasdasda",
          lastUpdate: DateTime.now(),
          lastChapter: "1",
          imageLink:
              "https://i.imgur.com/d9EEHCS.jpg",
          // "http://3.bp.blogspot.com/-LHURB4jzEx4/Xalm8fUkWUI/AAAAAAAAAk8/IcOExDRGY7c1um5Xi0ePNSZs6Lb0rmRCgCKgBGAsYHg/s0/02.jpg?imgmax=0",
        ),
      );
      print(_sameComics[i].id);
    }
    setBusySameComics(false);
  }
}
