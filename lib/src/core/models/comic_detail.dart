import 'package:json_annotation/json_annotation.dart';

// part 'comic_detail.g.dart';

@JsonSerializable()
class ComicDetail {
  final String name;
  final int lastChapter;
  final DateTime lastUpdate;
  final String imageLink;

  ComicDetail({this.name, this.lastChapter, this.lastUpdate, this.imageLink});

  // factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);
}
