import 'package:flutter/material.dart';
import 'package:uet_comic/src/core/models/author.dart';
import 'package:uet_comic/src/core/models/chapter.dart';
import 'package:uet_comic/src/core/models/comic.dart';
import 'package:uet_comic/src/core/models/comic_cover.dart';
import 'package:uet_comic/src/core/services/author.dart';
import 'package:uet_comic/src/core/services/chapter.dart';
import 'package:uet_comic/src/core/services/comic.dart';
import 'package:uet_comic/src/core/services/type.dart';
import 'package:uet_comic/src/core/view_models/base.dart';
import 'package:uet_comic/src/core/models/type.dart' as comic_type;

class ComicDetailPageModel extends BaseModel {
  ComicService comicService;
  ChapterService chapterService;
  TypeService typeService;
  AuthorService authorService;
  ComicDetailPageModel({@required this.comicService, this.chapterService, this.typeService, this.authorService});

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
      _comicDetail.author = await authorService.fetchAuthorById(_comicDetail.idAuthor);
      _comicDetail.types = [];
      List<comic_type.Type> types = [];
      for (var i = 0; i < _comicDetail.idTypes.length; i++) {
        comic_type.Type type = await typeService.fetchTypeById(_comicDetail.idTypes[i]);
        types.add(type);
      }
      _comicDetail.types = types;
    } catch (e) {
      print(e);
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
          imageLink:
              "https://i.imgur.com/d9EEHCS.jpg",
          // "http://3.bp.blogspot.com/-LHURB4jzEx4/Xalm8fUkWUI/AAAAAAAAAk8/IcOExDRGY7c1um5Xi0ePNSZs6Lb0rmRCgCKgBGAsYHg/s0/02.jpg?imgmax=0",
        ),
      );
    }
    setBusySameComics(false);
  }
}
