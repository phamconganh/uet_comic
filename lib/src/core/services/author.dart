import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uet_comic/src/core/models/author.dart';

class AuthorService {
  static final AuthorService instance = AuthorService.internal();
  AuthorService.internal();
  factory AuthorService() => instance;
  final CollectionReference ref = Firestore.instance.collection('author');

  Future<Author> fetchAuthorById(String id) async {
    DocumentSnapshot documentSnapshot = await ref.document(id).get();
    return Author.fromMap(documentSnapshot.data);
  }
}
