// import 'package:flutter/material.dart';
// import 'package:uet_comic/src/core/models/chapter.dart';

// class ChapterListModel extends ChangeNotifier {
//   final List<Chapter> chapters;
//   List<Chapter> _currentPage;
//   List<Chapter> get currentPage => _currentPage;
//   ChapterListModel({this.chapters}) {
//     if (chapters.length <= 10) {
//       _currentPage = chapters;
//     } else {
//       _currentPage = chapters.sublist(0, 10);
//     }
//   }

//   bool get isLoadAll => _currentPage.length >= chapters.length;

//   void loadMore() {
//     int startIndex = _currentPage.length;
//     int space = chapters.length - startIndex;
//     int endIndex = space >= 10 ? startIndex + 10 : startIndex + space;    
//     _currentPage.addAll(chapters.sublist(_currentPage.length, endIndex));
//   }
// }
