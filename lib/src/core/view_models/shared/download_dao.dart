// import 'package:flutter/material.dart';
// import 'package:sembast/sembast.dart';
// import 'package:uet_comic/src/core/models/comic.dart';
// import 'package:uet_comic/src/core/services/local.dart';

// class DownloadDao extends ChangeNotifier {
//   static const String DOWNLOADS_STORE_NAME = 'downloads';
//   final _downloadsStore = intMapStoreFactory.store(DOWNLOADS_STORE_NAME);
//   Future<Database> get _db async => await LocalService.instance.database;

//   DownloadDao() {
//     init();
//   }

//   List<Comic> _downloadedComics = [];
//   List<Comic> get downloadedComics => _downloadedComics;

//   Future init() async {
//     try {
//       final _downloadedComicsTmp = await _downloadsStore.find(await _db);
//       if(_downloadedComicsTmp != null) {
//         // do _downloadedComicsTmp la read-only
//         _downloadedComics = _downloadedComicsTmp.map((e) => Comic.fromMap(e.value)).toList();
//         print("_downloadedComics: $_downloadedComics");
//         notifyListeners();
//       }
//     } catch (e) {
//       print("Error in init DownloadDao : ${e.toString()}");
//     }
//   }

//   void add(Comic comic) {
//     print("Before add download: " + _downloadedComics.toString());
//     if (_downloadedComics.firstWhere((e) => e.id == comic.id) == null) {
//       _downloadedComics.add(comic);
//       print("After add download: " + _downloadedComics.toString());
//       notifyListeners();
//       rewrite();
//     }
//   }

//   void remove(String id) {
//     int index = _downloadedComics.;
//     print("Before remove download: " + _downloadedComics.toString());
//     if (index > -1) {
//       _downloadedComics.removeAt(index);
//       print("After remove download: " + _downloadedComics.toString());
//       notifyListeners();
//       rewrite();
//     }
//   }

//   Future rewrite() async {
//     await _downloadsRecord.put(await _db, _downloadedComics);
//   }
// }
