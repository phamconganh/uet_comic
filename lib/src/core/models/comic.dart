import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uet_comic/src/core/models/author.dart';
import 'package:uet_comic/src/core/models/type.dart' as comic_type;

class Comic {
  final String id;
  final String name;
  final String imageLink;
  final int state;
  final String content;
  int view;
  int like;
  int follow;
  final String lastChapter;
  final int age;
  final int gender;
  final DateTime lastUpdate;
  Author author;
  List<comic_type.Type> types;

  Comic({
    this.id,
    this.name,
    this.imageLink,
    this.state,
    this.content,
    this.view,
    this.like,
    this.follow,
    this.lastChapter,
    this.age,
    this.gender,
    this.lastUpdate,
    this.author,
    this.types,
  });

  factory Comic.fromMap(Map<String, dynamic> map) => Comic(
        id: map['id'] as String,
        name: map['name'] as String,
        imageLink: map['imageLink'] as String,
        state: map['state'] as int,
        content: map['content'] as String,
        view: map['view'] as int,
        like: map['like'] as int,
        follow: map['follow'] as int,
        lastChapter: map['lastChapter'] as String,
        age: map['age'] as int,
        gender: map['gender'] as int,
        lastUpdate: DateTime.parse(
            (map['lastUpdate'] as Timestamp).toDate().toString()),
        author: Author.fromMap(map['author']),
        types: (map['types'] as List)
            ?.map((e) => comic_type.Type.fromMap(e))
            ?.toList(),
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'name': name,
        'imageLink': imageLink,
        'state': state,
        'content': content,
        'view': view,
        'like': like,
        'follow': follow,
        'lastChapter': lastChapter,
        'age': age,
        'gender': gender,
        'lastUpdate': lastUpdate,
        'author': author.toMap(),
        'types': types.map((e) => e.toMap()),
      };
}
