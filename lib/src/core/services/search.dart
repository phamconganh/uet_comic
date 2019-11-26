import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService {
  static final SearchService instance = SearchService.internal();
  SearchService.internal();
  factory SearchService() => instance;

  static final String path = "search";
  final CollectionReference ref = Firestore.instance.collection(path);

  Stream<QuerySnapshot> searchNameComics(String name) {
    return ref.where("searchIndexs", arrayContains: name).snapshots();
  }
}
