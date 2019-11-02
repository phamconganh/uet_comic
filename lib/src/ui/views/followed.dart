import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uet_comic/src/core/view_models/views/followed.dart';
import 'package:uet_comic/src/ui/views/comic_detail.dart';
import 'package:uet_comic/src/ui/widgets/comic_cover.dart';

class FollowedPage extends StatefulWidget {
  @override
  _FollowedPageState createState() => _FollowedPageState();
}

class _FollowedPageState extends State<FollowedPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  FollowedPageModel followedPageModel;

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
    followedPageModel = FollowedPageModel();
    followedPageModel.fetchFollowedComics();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      builder: (_) => followedPageModel,
      child: Consumer<FollowedPageModel>(
        builder: (__, model, ___) => model.busy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: <Widget>[
                  const Divider(),
                  const ListTile(
                    leading:
                        const Icon(FontAwesomeIcons.heart, color: Colors.red),
                    title: const Text(
                      "Truyện đã theo dõi",
                      style: TextStyle(color: Colors.red),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      ComicCoverList(
                        comicCovers: model.followedComics,
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
