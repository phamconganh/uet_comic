class UserData {
  List<String> followedComics;
  List<String> likedComics;
  List<String> searchedComics;

  UserData({this.followedComics, this.likedComics, this.searchedComics});

  factory UserData.fromMap(Map<dynamic, dynamic> map) => UserData(
        followedComics: (map['followedComics'] as List).map((e)=>e.toString()).toList(),
        likedComics: (map['likedComics'] as List).map((e)=>e.toString()).toList(),
        searchedComics: (map['searchedComics'] as List).map((e)=>e.toString()).toList(),
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'followedComics': followedComics,
        'likedComics': likedComics,
        'searchedComics': searchedComics,
      };
}
