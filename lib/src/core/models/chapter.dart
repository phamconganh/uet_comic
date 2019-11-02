import 'package:cloud_firestore/cloud_firestore.dart';

class Chapter {
  final String id;
  final String name;
  final List<String> images;
  final String idComic;
  final DateTime lastUpdate;

  Chapter({
    this.id,
    this.name,
    this.idComic,
    this.lastUpdate,
    this.images
  });

  factory Chapter.fromMap(Map<String, dynamic> map) => Chapter(
    id: map['id']?.toString(),
    name: map['name']?.toString(),
    idComic: map['idComic']?.toString(),
    // lastUpdate: DateTime.parse((map['lastUpdate'] as Timestamp).toDate().toString()),
    images: (map['images'] as List)?.map((e) => e as String)?.toList(),
  );

  Map<String, dynamic> toMap() => <String, dynamic>{
    'id': id,
    'name': name,
    'idComic': idComic,
    'lastUpdate': lastUpdate,
    'images': images,
  };
}
