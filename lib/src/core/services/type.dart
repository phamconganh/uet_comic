import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uet_comic/src/core/models/type.dart' as comic_type;

class TypeService {
  static final TypeService instance = TypeService.internal();
  TypeService.internal();
  factory TypeService() => instance;

  static final String path = "type";
  final CollectionReference ref = Firestore.instance.collection(path);

  Future<List<comic_type.Type>> fetchTypes() async {
    QuerySnapshot querySnapshot = await ref.getDocuments();
    return querySnapshot.documents
        .map((e) => comic_type.Type.fromMap(e.data))
        .toList();
  }
}
