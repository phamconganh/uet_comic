// do ko co tim kiem boi tac gia nen tam thoi comment

// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:uet_comic/src/core/models/author.dart';

// class AuthorService {
//   static final AuthorService instance = AuthorService.internal();
//   AuthorService.internal();
//   factory AuthorService() => instance;

//   static final String path = "author";
//   final CollectionReference ref = Firestore.instance.collection(path);

//   Future<Author> fetchAuthorById(String id) async {
//     DocumentSnapshot documentSnapshot = await ref.document(id).get();
//     return Author.fromMap(documentSnapshot.data);
//   }
// }
