// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:uet_comic/src/core/models/chapter.dart';
// import 'package:uet_comic/src/core/services/api.dart';

// class ChapterService {
//   final Api _api = Api("chapter");

//   Future<List<Chapter>> fetchChapters() async {
//     var result = await _api.getDataCollection();
//     List<Chapter> chapters = result.documents
//         .map((doc) => Chapter.fromJson(doc.data, doc.documentID))
//         .toList();
//     return chapters;
//   }

//   Stream<QuerySnapshot> fetchChaptersAsStream() {
//     return _api.streamDataCollection();
//   }

//   Future<Chapter> getChapterById(String id) async {
//     var doc = await _api.getDocumentById(id);
//     return Chapter.fromJson(doc.data, doc.documentID);
//   }

//   Future removeChapter(String id) async {
//     await _api.removeDocument(id);
//     return;
//   }

//   Future updateChapter(Chapter data) async {
//     await _api.updateDocument(data.toJson(), data.id);
//     return;
//   }

//   Future addChapter(Chapter data) async {
//     var result = await _api.addDocument(data.toJson());

//     return;
//   }
// }
