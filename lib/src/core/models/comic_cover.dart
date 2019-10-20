class ComicCover {
  final String id;
  final String name;
  final String lastChapter;
  final DateTime lastUpdate;
  final String imageLink;

  ComicCover({this.id, this.name, this.lastChapter, this.lastUpdate, this.imageLink});

  factory ComicCover.fromMap(Map<String, dynamic> map, String id) => ComicCover(
    id: id,
    name: map['name'] as String,
    lastChapter: map['lastChapter'] as String,
    lastUpdate: map['lastUpdate'] as DateTime,
    imageLink: map['imageLink'] as String,
    // lastUpdate: map['lastUpdate'] as Timestamp,
  );
}
