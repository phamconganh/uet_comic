import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uet_comic/src/core/view_models/shared/follow_dao.dart';
import 'package:uet_comic/src/core/view_models/shared/like_dow.dart';
import 'package:uet_comic/src/core/view_models/views/comic_detail.dart';
import 'package:uet_comic/src/core/view_models/views/followed.dart';
import 'package:uet_comic/src/ui/shared/theme.dart';
import 'package:uet_comic/src/ui/views/comic_detail.dart';
import 'package:uet_comic/src/ui/widgets/comic_cover.dart';

class FollowedPage extends StatefulWidget {
  @override
  _FollowedPageState createState() => _FollowedPageState();
}

class _FollowedPageState extends State<FollowedPage> {
  void choosedComic(String idComic, String part) {
    var model = Provider.of<ComicDetailPageModel>(context);
    model.onLoadData(idComic);
    model.setFollow(
        Provider.of<FollowDao>(context).idFollowedComics.contains(idComic));
    model
        .setLike(Provider.of<LikeDao>(context).idLikedComics.contains(idComic));
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => ComicDetailPage(
          idComic: idComic,
          part: part,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FollowedPageModel>(
      builder: (__, model, ___) => model.busy
          ? Center(
              child: CircularProgressIndicator(),
            )
          : model.followedComics.length == 0
              ? Column(
                  children: <Widget>[
                    const Divider(),
                    ListTile(
                      leading:
                          const Icon(FontAwesomeIcons.heart, color: Colors.red),
                      title: const Text(
                        "Bạn chưa theo dõi truyện nào",
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
                          part: "Truyện đã theo dõi",
                        ),
                      ],
                    ),
                    heightPadding,
                  ],
                ),
    );
  }
}
