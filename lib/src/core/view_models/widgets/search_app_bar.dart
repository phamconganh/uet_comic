// import 'package:meta/meta.dart';
// import 'package:uet_comic/src/core/services/comic.dart';
import 'package:uet_comic/src/core/view_models/base.dart';

class SearcnhAppBarModel extends BaseModel {
  List<String> words;
  List<String> history;
  // ComicService _comicService;

  // SearcnhAppBarModel({
  //   @required ComicService comicService,
  // }) : _comicService = comicService;

  Future search(String key) async {
    // setBusy(true);
    // words = await _comicService.searchComicByName(key);
    // setBusy(false);
  }
}
