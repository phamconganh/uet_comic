import 'dart:async';
import 'dart:io' as Io;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image/image.dart';
import 'package:path_provider/path_provider.dart';

class LocalFileService {
  static final LocalFileService instance = LocalFileService.internal();
  LocalFileService.internal();
  factory LocalFileService() => instance;

  final cacheManager = DefaultCacheManager();

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<Io.File> getImageFromNetwork(String url) async {
    Io.File file = await cacheManager.getSingleFile(url);
    return file;
  }

  Future<String> saveImage(String url) async {
    final file = await getImageFromNetwork(url);
    //retrieve local path for device
    var path = await _localPath;
    Image image = decodeImage(file.readAsBytesSync());
    String fileName = getNameFile(url);
    String imageLink = path + fileName;
    Io.File(imageLink)..writeAsBytesSync(encodePng(image));
    return imageLink;
  }

  Future saveImages(List<String> urls) async {
    for (var i = 0; i < urls.length; i++) {
      var path = await _localPath;
    }
  }

  Stream<Io.File> saveImageStream(String url, String path) async* {
    final file = await getImageFromNetwork(url);
    Image image = decodeImage(file.readAsBytesSync());
    String fileName = getNameFile(url);
    yield Io.File('$path/$fileName')..writeAsBytesSync(encodePng(image));
  }

  // Stream saveImagesStream(List<String> urls) async {
  //   for (var i = 0; i < urls.length; i++) {
  //     final file = await getImageFromNetwork(urls[i]);
  //     //retrieve local path for device
  //     var path = await _localPath;
  //     Image image = decodeImage(file.readAsBytesSync());
  //     // Image thumbnail = copyResize(image, 120);

  //     // Save the thumbnail as a PNG.
  //     String fileName = getNameFile(urls[i]);
  //     Io.File('$path/$fileName')..writeAsBytesSync(encodePng(image));
  //   }
  // }

  String getNameFile(String url) => url.replaceAll("https://i.imgur.com/", "");
  // String getPathFile(String url) => url.replaceAll("https://i.imgur.com/", "");
}
