import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uet_comic/src/core/view_models/views/downloaded.dart';
import 'package:uet_comic/src/ui/views/comic_detail.dart';
import 'package:uet_comic/src/ui/widgets/comic_cover.dart';

class DownloadedPage extends StatefulWidget {
  @override
  _DownloadedPageState createState() => _DownloadedPageState();
}

class _DownloadedPageState extends State<DownloadedPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  DownloadedPageModel downloadedPageModel;

  void choosedComic(String idComic) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => ComicDetailPage(
          idComic: idComic,
        ),
      ),
    );
  }

  @override
  void initState() {
    downloadedPageModel = DownloadedPageModel();
    downloadedPageModel.fetchDownloadedComics();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      builder: (_) => downloadedPageModel,
      child: Consumer<DownloadedPageModel>(
        builder: (__, model, ___) => model.busy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: <Widget>[
                  const Divider(),
                  const ListTile(
                    leading: const Icon(Icons.folder, color: Colors.red),
                    title: const Text(
                      "Truyện đã theo dõi",
                      style: TextStyle(color: Colors.red),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      ComicCoverList(
                        comicCovers: model.downloadedComics,
                        choosedComic: choosedComic,
                      ),
                    ],
                  ),
                  const Divider(),
                ],
              ),
      ),
    );
  }
}
