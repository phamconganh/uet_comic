import 'package:json_annotation/json_annotation.dart';

// part 'comic_detail.g.dart';

@JsonSerializable()
class ComicDetail {
  final String env;
  final bool production;
  final String apiKey;

  ComicDetail({this.env, this.production, this.apiKey});

  // factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);
}
