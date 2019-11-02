import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uet_comic/src/core/models/comic.dart';
import 'package:uet_comic/src/core/models/comic_cover.dart';

class ComicService {
  // static final ComicService _instance = ComicService.internal();
  // ComicService.internal();
  // factory ComicService() => _instance;
  // final CollectionReference ref = Firestore.instance.collection('comic');
  CollectionReference ref = Firestore.instance.collection('comic');

  Future<List<ComicCover>> fetchNewComicCovers() async {
    QuerySnapshot data = await ref.orderBy("lastUpdate", descending: true).limit(10).getDocuments();
    return mapToComicCover(data);
  }

  Future<List<ComicCover>> fetchMaleComicCovers() async {
    QuerySnapshot data = await ref.where("gender", isEqualTo: 0).orderBy("view", descending: true).limit(10).getDocuments();
    return mapToComicCover(data);
  }

  Future<List<ComicCover>> fetchFemaleComicCovers() async {
    QuerySnapshot data = await ref.where("gender", isEqualTo: 1).orderBy("view", descending: true).limit(10).getDocuments();
    return mapToComicCover(data);
  }

  List<ComicCover> mapToComicCover(QuerySnapshot data) => data.documents.map((doc) => ComicCover.fromMap(doc.data)).toList();

  Future<Comic> fetchComicById(String id) async {
    DocumentSnapshot documentSnapshot = await ref.document(id).get();
    return Comic.fromMap(documentSnapshot.data);
  }

  Future<List<ComicCover>> fetchSameComicCover(List<String> idTypes) async {
    QuerySnapshot data = await ref.where("gender", isEqualTo: 1).orderBy("view", descending: true).limit(10).getDocuments();
    return mapToComicCover(data);
  }

  // Stream<QuerySnapshot> fetchComicsAsStream() {
  //   return _api.streamDataCollection();
  // }

  // Future<Comic> getComicById(String id) async {
  //   var doc = await _api.getDocumentById(id);
  //   return Comic.fromJson(doc.data, doc.documentID);
  // }

  // Future removeComic(String id) async {
  //   await _api.removeDocument(id);
  //   return;
  // }

  // Future updateComic(Comic data) async {
  //   await _api.updateDocument(data.toJson(), data.id);
  //   return;
  // }

  // Future addComic(Comic data) async {
  //   var result = await _api.addDocument(data.toJson());

  //   return;
  // }

  // Future<List<Comic>> searchComicByName(String key) async {
  //   var result = await _api.reference.where(
  //     "searchIndexs",
  //     arrayContains: key,
  //   );
  //   List<Comic> comics = [];
  //   // result.documents
  //   //     .map((doc) => Comic.fromJson(doc.data, doc.documentID))
  //   //     .toList();
  //   return comics;
  // }
}
