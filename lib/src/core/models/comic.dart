import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uet_comic/src/core/models/author.dart';
import 'package:uet_comic/src/core/models/chapter.dart';
import 'package:uet_comic/src/core/models/type.dart' as comic_type;

class Comic {
  final String id;
  final String name;
  final String imageLink;
  final int state;
  final String idAuthor;
  final String content;
  final List<String> idTypes;
  int view;
  int like;
  int follow;
  final List<String> idChapters;
  final int age;
  final int gender;
  final DateTime lastUpdate;
  Author author;
  List<comic_type.Type> types;
  List<Chapter> chapters;

  Comic({
    this.id,
    this.name,
    this.imageLink,
    this.state,
    this.idAuthor,
    this.content,
    this.idTypes,
    this.view,
    this.like,
    this.follow,
    this.idChapters,
    this.age,
    this.gender,
    this.lastUpdate,
    this.author,
    this.types,
    this.chapters
  });

  factory Comic.fromMap(Map<String, dynamic> map) => Comic(
        id: map['id'] as String,
        name: map['name'] as String,
        imageLink: map['imageLink'] as String,
        state: map['state'] as int,
        idAuthor: map['idAuthor']?.toString(),
        content: map['content'] as String,
        idTypes: (map['idTypes'] as List)?.map((e) => e as String)?.toList(),
        view: map['view'] as int,
        like: map['like'] as int,
        follow: map['follow'] as int,
        idChapters:
            (map['idChapters'] as List)?.map((e) => e as String)?.toList(),
        age: map['age'] as int,
        gender: map['gender'] as int,
        lastUpdate: DateTime.parse(
            (map['lastUpdate'] as Timestamp).toDate().toString()),
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'name': name,
        'imageLink': imageLink,
        'state': state,
        'idAuthor': idAuthor,
        'content': content,
        'idTypes': idTypes,
        'view': view,
        'like': like,
        'follow': follow,
        'idChapters': idChapters,
        'age': age,
        'gender': gender,
        'lastUpdate': lastUpdate,
      };
}
