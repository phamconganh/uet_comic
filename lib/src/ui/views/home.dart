import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uet_comic/src/core/models/comic_cover.dart';
import 'package:uet_comic/src/core/view_models/shared/follow_dao.dart';
import 'package:uet_comic/src/core/view_models/shared/like_dao.dart';
import 'package:uet_comic/src/core/view_models/views/comic_detail.dart';
import 'package:uet_comic/src/core/view_models/views/home.dart';
import 'package:uet_comic/src/ui/views/comic_detail.dart';
import 'package:uet_comic/src/ui/widgets/comic_cover.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void onChoosedComic(ComicCover comicCover, String part) {
    var model = Provider.of<ComicDetailPageModel>(context);
    model.clear();
    model.onLoadData(comicCover.id);
    model.setDownloaded(false);
    model.setFollow(
        Provider.of<FollowDao>(context).idFollowedComics.contains(comicCover.id));
    model
        .setLike(Provider.of<LikeDao>(context).idLikedComics.contains(comicCover.id));

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
    return Consumer<HomePageModel>(
      builder: (_, model, __) {
        return RefreshIndicator(
          onRefresh: model.onLoadData,
          child: ListView(
            children: <Widget>[
              const Divider(),
              const ListTile(
                leading: const Icon(Icons.fiber_new, color: Colors.blue),
                title: const Text(
                  "Truyện mới cập nhật",
                  style: TextStyle(color: Colors.blue),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                child: model.isFetchingNewComicCovers
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: <Widget>[
                          ComicCoverList(
                            comicCovers: model.newComicCovers,
                            onChoosedComic: onChoosedComic,
                            part: "home_page",
                          ),
                        ],
                      ),
              ),
              const Divider(),
              const ListTile(
                leading: const Icon(
                  FontAwesomeIcons.male,
                  color: Colors.red,
                ),
                title: const Text(
                  "Truyện con trai",
                  style: TextStyle(color: Colors.red),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                child: model.isFetchingMaleComicCovers
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: <Widget>[
                          ComicCoverList(
                            comicCovers: model.maleComicCovers,
                            onChoosedComic: onChoosedComic,
                            part: "man_comic",
                          ),
                        ],
                      ),
              ),
              const Divider(),
              const ListTile(
                leading: const Icon(
                  FontAwesomeIcons.female,
                  color: Colors.orange,
                ),
                title: const Text(
                  "Truyện con gái",
                  style: TextStyle(color: Colors.orange),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                child: model.isFetchingFemaleComicCovers
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: <Widget>[
                          ComicCoverList(
                            comicCovers: model.femaleComicCovers,
                            onChoosedComic: onChoosedComic,
                            part: "woman_comic",
                          ),
                        ],
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
