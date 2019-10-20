// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:uet_comic/src/core/models/Type.dart';
// import 'package:uet_comic/src/core/services/api.dart';

// class TypeService {
//   final Api _api = Api("Type");

//   Future<List<Type>> fetchChapters() async {
//     var result = await _api.getDataCollection();
//     List<Type> types = result.documents
//         .map((doc) => Type.fromJson(doc.data, doc.documentID))
//         .toList();
//     return types;
//   }

//   Stream<QuerySnapshot> fetchChaptersAsStream() {
//     return _api.streamDataCollection();
//   }

//   Future<Type> getChapterById(String id) async {
//     var doc = await _api.getDocumentById(id);
//     return Type.fromJson(doc.data, doc.documentID);
//   }

//   Future removeChapter(String id) async {
//     await _api.removeDocument(id);
//     return;
//   }

//   Future updateChapter(Type data) async {
//     await _api.updateDocument(data.toJson(), data.id);
//     return;
//   }

//   Future addChapter(Type data) async {
//     var result = await _api.addDocument(data.toJson());

//     return;
//   }
// }
