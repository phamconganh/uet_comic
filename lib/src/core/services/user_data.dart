import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uet_comic/src/core/models/user_data.dart';

class UserDataService {
  static final UserDataService instance = UserDataService.internal();
  UserDataService.internal();
  factory UserDataService() => instance;

  static final String path = "user_data";
  final CollectionReference ref = Firestore.instance.collection(path);

  Future<UserData> fetchUserData(String uid) async {
    DocumentSnapshot documentSnapshot = await ref.document(uid).get();
    if (documentSnapshot.data == null) return null;
    return UserData.fromMap(documentSnapshot.data);
  }

  void addFollowedComic(String uid, String followedComic) async {
    DocumentReference documentReference = ref.document(uid);
    var snapshot = await documentReference.get();
    if (snapshot.data == null) {
      documentReference.setData(UserData(
          followedComics: [followedComic],
          searchedComics: [],
          likedComics: []).toMap());
    } else {
      await documentReference.updateData({
        "followedComics": FieldValue.arrayUnion([followedComic])
      });
    }
  }

  void removeFollowedComic(String uid, String followedComic) async {
    DocumentReference documentReference = ref.document(uid);
    var snapshot = await documentReference.get();
    if (snapshot.data != null) {
      await documentReference.updateData({
        "followedComics": FieldValue.arrayRemove([followedComic])
      });
    }
  }

  void addLikedComic(String uid, String likedComics) async {
    DocumentReference documentReference = ref.document(uid);
    var snapshot = await documentReference.get();
    if (snapshot.data == null) {
      documentReference.setData(UserData(
          followedComics: [],
          searchedComics: [],
          likedComics: [likedComics]).toMap());
    } else {
      await documentReference.updateData({
        "likedComics": FieldValue.arrayUnion([likedComics])
      });
    }
  }

  void removeLikedComic(String uid, String likedComics) async {
    DocumentReference documentReference = ref.document(uid);
    var snapshot = await documentReference.get();
    if (snapshot.data != null) {
      await documentReference.updateData({
        "likedComics": FieldValue.arrayRemove([likedComics])
      });
    }
  }

  void addSearchedComic(String uid, String searchedComics) async {
    DocumentReference documentReference = ref.document(uid);
    var snapshot = await documentReference.get();
    if (snapshot.data == null) {
      documentReference.setData(UserData(
          followedComics: [],
          searchedComics: [searchedComics],
          likedComics: []).toMap());
    } else {
      await documentReference.updateData({
        "searchedComics": FieldValue.arrayUnion([searchedComics])
      });
    }
  }

  void removeSearchedComic(String uid, String searchedComics) async {
    DocumentReference documentReference = ref.document(uid);
    var snapshot = await documentReference.get();
    if (snapshot.data != null) {
      await documentReference.updateData({
        "searchedComics": FieldValue.arrayRemove([searchedComics])
      });
    }
  }
}
