import 'package:flutter/material.dart';
import 'package:uet_comic/src/core/models/chapter.dart';
import 'package:uet_comic/src/core/models/comic.dart';
import 'package:uet_comic/src/core/models/comic_cover.dart';
import 'package:uet_comic/src/core/services/author.dart';
import 'package:uet_comic/src/core/services/chapter.dart';
import 'package:uet_comic/src/core/services/comic.dart';
import 'package:uet_comic/src/core/services/type.dart';

class ComicDetailPageModel extends ChangeNotifier {
  ComicService comicService = ComicService();
  ChapterService chapterService = ChapterService();
  TypeService typeService = TypeService();
  AuthorService authorService = AuthorService();

  bool _isFollowed = false;
  bool get isFollowed => _isFollowed;
  void setFollow(bool value) {
    _isFollowed = value;
    notifyListeners();
  }

  bool _isLiked = false;
  bool get isLiked => _isLiked;
  void setLike(bool value) {
    _isLiked = value;
    notifyListeners();
  }

  Future<void> onLoadData(idComic) async {
    if (idComic != null) {
      fetchComicDetail(idComic);
      fetchChapters(idComic);
      fetchSameComics();
    }
    return;
  }

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
    try {
      _comicDetail = await comicService.fetchComicById(idComic);
    } catch (e) {
      print("Error fetchComicDetail: ${e.toString()}");
    }
    setBusyComicDetail(false);
  }

  Future fetchChapters(String idComic) async {
    setBusyChapters(true);
    _chapters = await chapterService.fetchChaptersByIdComic(idComic);
    setBusyChapters(false);
  }

  Future fetchSameComics() async {
    setBusySameComics(true);
    for (var i = 0; i < 6; i++) {
      _sameComics.add(
        ComicCover(
          id: (i + 30).toString(),
          name: "Test asdasd asdasdasd adasdasd asdasdad adasdasda",
          lastUpdate: DateTime.now(),
          lastChapter: "1",
          imageLink: "https://i.imgur.com/d9EEHCS.jpg",
          // "http://3.bp.blogspot.com/-LHURB4jzEx4/Xalm8fUkWUI/AAAAAAAAAk8/IcOExDRGY7c1um5Xi0ePNSZs6Lb0rmRCgCKgBGAsYHg/s0/02.jpg?imgmax=0",
        ),
      );
    }
    setBusySameComics(false);
  }
}
