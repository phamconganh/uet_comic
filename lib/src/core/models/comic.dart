// import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:uet_comic/src/core/models/author.dart';
import 'package:uet_comic/src/core/models/chapter.dart';
import 'package:uet_comic/src/core/models/type.dart' as uet_comic_type;

class Comic {
  final String id;
  final String name;
  final String imageLink;
  final int state;
  final Author author;
  final String content;
  final List<uet_comic_type.Type> types;
  final int view;
  final int like;
  final int follow;
  final List<Chapter> chapters;
  final int age;
  final int gender;
  // final Timestamp lastUpdate;

  Comic({
    this.id,
    this.name,
    this.imageLink,
    this.state,
    this.author,
    this.content,
    this.types,
    this.view,
    this.like,
    this.follow,
    this.chapters,
    this.age,
    this.gender,
    // this.lastUpdate,
  });

  factory Comic.fromMap(Map<String, dynamic> map, String id) => Comic(
    id: id,
    name: map['name'] as String,
    imageLink: map['imageLink'] as String,
    state: map['state'] as int,
    // idAuthor: map['idAuthor'] as String,
    content: map['content'] as String,
    // types: (map['types'] as List)?.map((e) => e as String)?.toList(),
    view: map['view'] as int,
    like: map['like'] as int,
    follow: map['follow'] as int,
    // chapters: (map['chapters'] as List)?.map((e) => e as String)?.toList(),
    age: map['age'] as int,
    gender: map['gender'] as int,
    // lastUpdate: map['lastUpdate'] as Timestamp,
  );

  Map<String, dynamic> toMap() => <String, dynamic>{
      'id': id,
      'name': name,
      'imageLink': imageLink,
      'state': state,
      'idAuthor': author,
      'content': content,
      'types': types,
      'view': view,
      'like': like,
      'follow': follow,
      'chapters': chapters,
      'age': age,
      'gender': gender,
    };

}
