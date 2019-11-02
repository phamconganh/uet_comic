import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uet_comic/src/core/models/type.dart' as comic_type;

class TypeService {
  CollectionReference ref = Firestore.instance.collection('type');

  Future<comic_type.Type> fetchTypeById(String id) async {
    DocumentSnapshot documentSnapshot = await ref.document(id).get();
    return comic_type.Type.fromMap(documentSnapshot.data);
  }
}
