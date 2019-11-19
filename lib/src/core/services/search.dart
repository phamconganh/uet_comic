import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService {
  static final SearchService instance = SearchService.internal();
  SearchService.internal();
  factory SearchService() => instance;

  final CollectionReference ref = Firestore.instance.collection('search');

  // Future<List<Search>> fetchNameComic(String name) async {
  //   QuerySnapshot querySnapshot = await ref.where("searchIndexs", arrayContains: name).getDocuments();
  //   return querySnapshot.documents.map((e) => Search.fromMap(e.data)).toList();
  // }

  Stream<QuerySnapshot> searchNameComics(String name) {
    return ref.where("searchIndexs", arrayContains: name).snapshots();
  }

}
