import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uet_comic/src/core/models/comic_cover.dart';
import 'package:uet_comic/src/core/view_models/shared/comic_dao.dart';
import 'package:uet_comic/src/core/view_models/views/comic_detail.dart';
import 'package:uet_comic/src/ui/views/comic_detail.dart';
import 'package:uet_comic/src/ui/widgets/comic_cover.dart';

class DownloadedPage extends StatefulWidget {
  @override
  _DownloadedPageState createState() => _DownloadedPageState();
}

class _DownloadedPageState extends State<DownloadedPage> {
  void choosedComic(ComicCover comicCover, String part) {
    ComicDetailPageModel comicDetailPageModel = Provider.of(context);
    comicDetailPageModel.setComicDetail(comicCover);
    comicDetailPageModel.setDownloaded(true);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => ComicDetailPage(
          part: part,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ComicDao>(
      builder: (__, model, ___) => model.downloadedComics.length == 0
          ? ListView(
              children: <Widget>[
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.folder, color: Colors.red),
                  title: const Text(
                    "Bạn chưa tải truyện nào",
                    style: TextStyle(color: Colors.red),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            )
          : ListView(
              children: <Widget>[
                const Divider(),
                const ListTile(
                  leading: const Icon(Icons.folder, color: Colors.red),
                  title: const Text(
                    "Truyện đã tải",
                    style: TextStyle(color: Colors.red),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Column(
                  children: <Widget>[
                    ComicCoverList(
                      comicCovers: model.downloadedComics,
                      choosedComic: choosedComic,
                      isDownloaded: true,
                      part: "downloaded_page",
                    ),
                  ],
                ),
                const Divider(),
              ],
            ),
    );
  }
}
