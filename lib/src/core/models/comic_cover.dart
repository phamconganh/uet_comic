import 'package:cloud_firestore/cloud_firestore.dart';

class ComicCover {
  final String id;
  final String name;
  final String lastChapter;
  final DateTime lastUpdate;
  String imageLink;

  ComicCover(
      {this.id, this.name, this.lastChapter, this.lastUpdate, this.imageLink});

  factory ComicCover.fromMap(Map<String, dynamic> map) => ComicCover(
        id: map['id'] as String,
        name: map['name'] as String,
        lastChapter: map['lastChapter'] as String,
        lastUpdate: DateTime.parse(map['lastUpdate'].runtimeType == Timestamp
            ? map['lastUpdate'].toDate().toString()
            : map['lastUpdate'].toString()),
        imageLink: map['imageLink'] as String,
      );
}
