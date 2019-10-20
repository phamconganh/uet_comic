// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:uet_comic/src/core/models/Author.dart';
// import 'package:uet_comic/src/core/services/api.dart';

// class AuthorService {
//   final Api _api = Api("Author");

//   Future<List<Author>> fetchChapters() async {
//     var result = await _api.getDataCollection();
//     List<Author> authors = result.documents
//         .map((doc) => Author.fromJson(doc.data, doc.documentID))
//         .toList();
//     return authors;
//   }

//   Stream<QuerySnapshot> fetchChaptersAsStream() {
//     return _api.streamDataCollection();
//   }

//   Future<Author> getChapterById(String id) async {
//     var doc = await _api.getDocumentById(id);
//     return Author.fromJson(doc.data, doc.documentID);
//   }

//   Future removeChapter(String id) async {
//     await _api.removeDocument(id);
//     return;
//   }

//   Future updateChapter(Author data) async {
//     await _api.updateDocument(data.toJson(), data.id);
//     return;
//   }

//   Future addChapter(Author data) async {
//     var result = await _api.addDocument(data.toJson());

//     return;
//   }
// }
