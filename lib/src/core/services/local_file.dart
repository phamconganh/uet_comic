import 'dart:async';
import 'dart:io';
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

  Future<File> getImageFromNetwork(String url) async {
    File file = await cacheManager.getSingleFile(url);
    return file;
  }

  Future<String> saveImage(
      {String url, String comicFolder, String chapterFolder}) async {
    final file = await getImageFromNetwork(url);
    //retrieve local path for device
    var path = await _localPath;
    Image image = decodeImage(file.readAsBytesSync());
    String fileName = getNameFile(url);
    String imageLink = path + '/';
    if (comicFolder != null) {
      imageLink += comicFolder + '/';
      if (chapterFolder != null) {
        imageLink += chapterFolder + '/';
      }
    }

    imageLink += fileName;
    File newfile = await File(imageLink).create(recursive: true);
    newfile.writeAsBytesSync(encodePng(image));
    return imageLink;
  }

  void deleteComicFolder(String idComic) async {
    try {
      var path = await _localPath;
      final dir = Directory(path + "/" + idComic);
      dir.deleteSync(recursive: true);
    } catch (e) {
      print("Error delete folder: $idComic");
    }
  }

  String getNameFile(String url) => url.replaceAll("https://i.imgur.com/", "");
}
