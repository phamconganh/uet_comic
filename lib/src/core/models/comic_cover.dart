import 'package:json_annotation/json_annotation.dart';

// part 'comic_cover.g.dart';

@JsonSerializable()
class ComicCover {
  final String id;
  final String name;
  final int lastChapter;
  final DateTime lastUpdate;
  final String imageLink;

  ComicCover({this.id, this.name, this.lastChapter, this.lastUpdate, this.imageLink});

  // factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);
}
