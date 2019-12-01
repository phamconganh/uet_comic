import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uet_comic/src/core/models/comic_cover.dart';
import 'package:uet_comic/src/core/services/local_file.dart';
import 'package:uet_comic/src/core/view_models/shared/chapter_dao.dart';
import 'package:uet_comic/src/core/view_models/shared/comic_dao.dart';
// import 'package:uet_comic/src/core/view_models/shared/follow_dao.dart';
// import 'package:uet_comic/src/core/view_models/shared/like_dao.dart';
import 'package:uet_comic/src/core/view_models/views/comic_detail.dart';
import 'package:uet_comic/src/ui/shared/theme.dart';
import 'package:uet_comic/src/ui/views/comic_detail.dart';
import 'package:uet_comic/src/ui/widgets/comic_cover.dart';
import 'package:uet_comic/src/ui/widgets/dialogs.dart';

class DownloadedPage extends StatefulWidget {
  @override
  _DownloadedPageState createState() => _DownloadedPageState();
}

class _DownloadedPageState extends State<DownloadedPage> {
  void onChoosedComic(ComicCover comicCover, String part) async {
    ComicDetailPageModel comicDetailPageModel = Provider.of(context);
    ChapterDao chapterDao = Provider.of(context);
    comicDetailPageModel.clear();
    comicDetailPageModel.setComicDetail(comicCover);
    comicDetailPageModel
        .setChapters(await chapterDao.getChaptersByComicId(comicCover.id));
    comicDetailPageModel.setDownloaded(true);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => ComicDetailPage(
          part: part,
        ),
      ),
    );
  }

  void onDeleteComic(ComicCover comicCover) async {
    bool confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return Confirm(
          header: 'Xóa truyện',
          message: "Bạn muốn xóa truyện \"${comicCover.name}\"",
          okText: 'Xóa',
          cancelText: 'Hủy',
        );
      },
    );
    if (confirm) {
      Provider.of<ComicDao>(context).remove(comicCover.id);
      Provider.of<ChapterDao>(context).removeByIdComic(comicCover.id);
      LocalFileService.instance.deleteComicFolder(comicCover.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ComicDao>(
      builder: (__, model, ___) => model.downloadedComics.length == 0
          ? Card(
              child: ListTile(
                leading: const Icon(Icons.folder, color: Colors.pink),
                title: const Text(
                  "Bạn chưa tải truyện nào",
                  style: TextStyle(color: Colors.pink),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          : Card(
              child: ListView(
                children: <Widget>[
                  const ListTile(
                    leading: const Icon(Icons.folder, color: Colors.pink),
                    title: const Text(
                      "Truyện đã tải",
                      style: TextStyle(color: Colors.pink),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      ComicCoverList(
                        comicCovers: model.downloadedComics,
                        onChoosedComic: onChoosedComic,
                        isDownloaded: true,
                        onDeleteComic: onDeleteComic,
                        part: "downloaded_page",
                      ),
                    ],
                  ),
                  heightPadding,
                ],
              ),
            ),
    );
  }
}
