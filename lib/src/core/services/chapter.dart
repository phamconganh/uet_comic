import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uet_comic/src/core/models/chapter.dart';

class ChapterService {
  static final ChapterService instance = ChapterService.internal();
  ChapterService.internal();
  factory ChapterService() => instance;
  final CollectionReference ref = Firestore.instance.collection('chapter');

  Future<List<Chapter>> fetchChaptersByIdComic(String idComic) async {
    QuerySnapshot data =
        await ref.where("idComic", isEqualTo: idComic).getDocuments();
    return data.documents.map((doc) => Chapter.fromMap(doc.data)).toList();
  }
}
