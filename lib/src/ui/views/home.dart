import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uet_comic/src/core/view_models/shared/follow_dao.dart';
import 'package:uet_comic/src/core/view_models/shared/like_dow.dart';
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
                            choosedComic: choosedComic,
                            part: "Truyện mới cập nhật",
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
                            choosedComic: choosedComic,
                            part: "Truyện con trai",
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
                            choosedComic: choosedComic,
                            part: "Truyện con gái",
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
