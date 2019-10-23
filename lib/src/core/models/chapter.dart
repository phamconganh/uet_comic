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

  factory Chapter.fromMap(Map<String, dynamic> map, String id) => Chapter(
    id: id,
    name: map['name'] as String,
    idComic: map['idComic'] as String,
    lastUpdate: map['lastUpdate'] as DateTime,
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