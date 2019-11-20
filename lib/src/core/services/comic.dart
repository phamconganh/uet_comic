import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uet_comic/src/core/constants/app_contstants.dart';
import 'package:uet_comic/src/core/models/comic.dart';
import 'package:uet_comic/src/core/models/comic_cover.dart';

class ComicService {
  static final ComicService instance = ComicService.internal();
  ComicService.internal();
  factory ComicService() => instance;

  final CollectionReference ref = Firestore.instance.collection('comic');

  Future<List<ComicCover>> fetchNewComicCovers() async {
    QuerySnapshot data = await ref
        .orderBy("lastUpdate", descending: true)
        .limit(10)
        .getDocuments();
    return mapToComicCover(data);
  }

  Future<List<ComicCover>> fetchMaleComicCovers() async {
    QuerySnapshot data = await ref
        .where("gender", isEqualTo: 0)
        .orderBy("view", descending: true)
        .limit(10)
        .getDocuments();
    return mapToComicCover(data);
  }

  Future<List<ComicCover>> fetchFemaleComicCovers() async {
    QuerySnapshot data = await ref
        .where("gender", isEqualTo: 1)
        .orderBy("view", descending: true)
        .limit(10)
        .getDocuments();
    return mapToComicCover(data);
  }

  List<ComicCover> mapToComicCover(QuerySnapshot data) =>
      data.documents.map((doc) => ComicCover.fromMap(doc.data)).toList();

  Future<Comic> fetchComicById(String id) async {
    DocumentSnapshot documentSnapshot = await ref.document(id).get();
    return Comic.fromMap(documentSnapshot.data);
  }

  Future<List<ComicCover>> fetchSameComicCover(List<String> idTypes) async {
    QuerySnapshot data = await ref
        .where("gender", isEqualTo: 1)
        .orderBy("view", descending: true)
        .limit(10)
        .getDocuments();
    return mapToComicCover(data);
  }

  Future<List<ComicCover>> fetchFollowedComicCovers(
      List<String> idFollowedComics) async {
    List<ComicCover> followedComicCovers = [];
    for (var i = 0; i < idFollowedComics.length; i++) {
      DocumentSnapshot documentSnapshot =
          await ref.document(idFollowedComics[i]).get();
      if (documentSnapshot != null) {
        followedComicCovers.add(ComicCover.fromMap(documentSnapshot.data));
      }
    }
    return followedComicCovers;
  }

  Future<List<ComicCover>> fetchComicCoversByName(String name) async {
    QuerySnapshot querySnapshot =
        await ref.where("searchIndexs", arrayContains: name).getDocuments();
    return querySnapshot.documents
        .map((e) => ComicCover.fromMap(e.data))
        .toList();
  }

  Future<List<ComicCover>> fetchComicCoversByFilter(
    String idType,
    int state,
    int gender,
    Age age,
    Sort sort,
  ) async {
    Query query = ref.limit(10);
    if (idType != null) query = query.where("idTypes", arrayContains: idType);
    if (state != null) query = query.where("state", isEqualTo: state);
    if (gender != null) query = query.where("gender", isEqualTo: gender);
    if (age != null) {
      switch (age) {
        case Age.UNDER_12:
          query = query.where("age", isLessThan: 12).orderBy("age");
          break;
        case Age.FROM_12_TO_18:
          query = query
              .where("age", isGreaterThanOrEqualTo: 12, isLessThan: 18)
              .orderBy("age");
          break;
        case Age.UPPER_18:
          query = query.where("age", isGreaterThanOrEqualTo: 18).orderBy("age");
          break;
        default:
          break;
      }
    }
    if (sort != null) {
      switch (sort) {
        case Sort.DESC_VIEW:
          query = query.orderBy("view", descending: true);
          break;
        case Sort.ASC_VIEW:
          query = query.orderBy("view");
          break;
        default:
          break;
      }
    }
    QuerySnapshot querySnapshot = await query.getDocuments();
    return querySnapshot.documents
        .map((e) => ComicCover.fromMap(e.data))
        .toList();
  }

  void likeComic(String id) async {
    await ref.document(id).updateData({"like": FieldValue.increment(1)});
  }

  void dislikeComic(String id) async {
    await ref.document(id).updateData({"like": FieldValue.increment(-1)});
  }

  void folloComic(String id) async {
    await ref.document(id).updateData({"follow": FieldValue.increment(1)});
  }

  void unfolloComic(String id) async {
    await ref.document(id).updateData({"follow": FieldValue.increment(-1)});
  }

  void viewComic(String id) async {
    await ref.document(id).updateData({"view": FieldValue.increment(1)});
  }
}
