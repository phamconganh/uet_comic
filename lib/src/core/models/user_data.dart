class UserData {
  List<String> followedComics;
  List<String> likedComics;
  List<String> searchedComics;

  UserData({this.followedComics, this.likedComics, this.searchedComics});

  factory UserData.fromMap(Map<dynamic, dynamic> map) => UserData(
        followedComics: map['followedComics'] as List<String>,
        likedComics: map['likedComics'] as List<String>,
        searchedComics: map['searchedComics'] as List<String>,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'followedComics': followedComics,
        'likedComics': likedComics,
        'searchedComics': searchedComics,
      };
}
