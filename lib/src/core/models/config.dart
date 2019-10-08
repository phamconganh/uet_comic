import 'package:json_annotation/json_annotation.dart';

part 'config.g.dart';

@JsonSerializable(createToJson: false)
class Config {
  final String env;
  final bool production;
  final String apiKey;

  Config({this.env, this.production, this.apiKey});

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);
}
