import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uet_comic/src/core/models/chapter.dart';

class ChapterService {
  static final ChapterService instance = ChapterService.internal();
  ChapterService.internal();
  factory ChapterService() => instance;

  static final String path = "chapter";
  final CollectionReference ref = Firestore.instance.collection(path);

  Future<List<Chapter>> fetchChaptersByIdComic(String idComic) async {
    QuerySnapshot data =
        await ref.where("idComic", isEqualTo: idComic).orderBy("index", descending: true).getDocuments();
    return data.documents.map((doc) => Chapter.fromMap(doc.data)).toList();
  }
}
