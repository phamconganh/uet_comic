import 'package:flutter/material.dart';
import 'package:uet_comic/src/core/models/chapter.dart';
import 'package:uet_comic/src/core/models/comic.dart';
import 'package:uet_comic/src/core/services/chapter.dart';
import 'package:uet_comic/src/core/services/comic.dart';

class ComicDetailPageModel extends ChangeNotifier {

  bool _isDownloaded = false;
  bool get isDownloaded => _isDownloaded;
  void setDownloaded(bool value) {
    _isDownloaded = value;
    notifyListeners();
  }

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
    }
    return;
  }

  bool _isFetchingComicDetail = false;
  bool get isFetchingComicDetail => _isFetchingComicDetail;
  void setBusyComicDetail(bool value) {
    _isFetchingComicDetail = value;
    notifyListeners();
  }

  Comic _comicDetail;
  Comic get comicDetail => _comicDetail;
  void setComicDetail(Comic comic) {
    _comicDetail = comic;
    notifyListeners();
  }

  bool _isFetchingChapters = false;
  bool get isFetchingChapters => _isFetchingChapters;
  void setBusyChapters(bool value) {
    _isFetchingChapters = value;
    notifyListeners();
  }

  List<Chapter> _chapters = [];
  List<Chapter> get chapters => _chapters;
  void setChapters(List<Chapter> chapters) {
    _chapters = chapters;
    notifyListeners();
  }

  Future fetchComicDetail(String idComic) async {
    setBusyComicDetail(true);
    try {
      _comicDetail = await ComicService.instance.fetchComicById(idComic);
      if (_comicDetail.like == 0 && _isLiked == true) _isLiked = false;
      if (_comicDetail.follow == 0 && _isFollowed == true) _isFollowed = false;
    } catch (e) {
      print("Error fetchComicDetail: ${e.toString()}");
    }
    setBusyComicDetail(false);
  }

  Future fetchChapters(String idComic) async {
    setBusyChapters(true);
    _chapters = await ChapterService.instance.fetchChaptersByIdComic(idComic);
    setBusyChapters(false);
  }

  void like() {
    if (_comicDetail != null) {
      ComicService.instance.likeComic(_comicDetail.id);
      _comicDetail.like++;
      setLike(true);
    }
  }

  void dislike() {
    if (_comicDetail != null) {
      ComicService.instance.dislikeComic(_comicDetail.id);
      if (_comicDetail.like > 0) _comicDetail.like--;
      setLike(false);
    }
  }

  void follow() {
    if (_comicDetail != null) {
      ComicService.instance.folloComic(_comicDetail.id);
      _comicDetail.follow++;
      setFollow(true);
    }
  }

  void unfollow() {
    if (_comicDetail != null) {
      ComicService.instance.unfolloComic(_comicDetail.id);
      if (_comicDetail.follow > 0) _comicDetail.follow--;
      setFollow(false);
    }
  }

  void read() {
    if (_comicDetail != null) {
      ComicService.instance.viewComic(_comicDetail.id);
      _comicDetail.view++;
      notifyListeners();
    }
  }
}
