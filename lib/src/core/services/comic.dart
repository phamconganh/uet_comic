// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:uet_comic/src/core/models/comic.dart';

// class ComicService {
//   static final ComicService _instance = ComicService.internal();
//   ComicService.internal();
//   factory ComicService() => _instance;
//   final CollectionReference ref = Firestore.instance.collection('comic');

//   Future<List<Comic>> fetchComics() async {
//     ref.document();
//     var result = await _api.getDataCollection();
//     List<Comic> comics = result.documents
//         .map((doc) => Comic.fromJson(doc.data, doc.documentID))
//         .toList();
//     return comics;
//   }

//   Future<List<Comic>> fetchNewComicCovers() async {
//     ref.where(field);
//   }

//   Future<List<Comic>> fetchMaleComicCovers() async {
//     ref.where(field);
//   }

//   Future<List<Comic>> fetchFemaleComicCovers() async {
//     ref.where(field);
//   }


//   // Stream<QuerySnapshot> fetchComicsAsStream() {
//   //   return _api.streamDataCollection();
//   // }

//   // Future<Comic> getComicById(String id) async {
//   //   var doc = await _api.getDocumentById(id);
//   //   return Comic.fromJson(doc.data, doc.documentID);
//   // }

//   // Future removeComic(String id) async {
//   //   await _api.removeDocument(id);
//   //   return;
//   // }

//   // Future updateComic(Comic data) async {
//   //   await _api.updateDocument(data.toJson(), data.id);
//   //   return;
//   // }

//   // Future addComic(Comic data) async {
//   //   var result = await _api.addDocument(data.toJson());

//   //   return;
//   // }

//   // Future<List<Comic>> searchComicByName(String key) async {
//   //   var result = await _api.reference.where(
//   //     "searchIndexs",
//   //     arrayContains: key,
//   //   );
//   //   List<Comic> comics = [];
//   //   // result.documents
//   //   //     .map((doc) => Comic.fromJson(doc.data, doc.documentID))
//   //   //     .toList();
//   //   return comics;
//   // }
// }
