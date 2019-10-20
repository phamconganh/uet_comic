import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:uet_comic/src/core/view_models/views/home.dart';
import 'package:uet_comic/src/ui/views/comic_detail.dart';
import 'package:uet_comic/src/ui/widgets/comic_cover.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageModel homePageModel;

  // RefreshController _refreshController = RefreshController(initialRefresh: false);
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
  Widget build(BuildContext context) {
    if (homePageModel == null) {
      homePageModel = HomePageModel();
      homePageModel.fetchDatas();
    }

    return ChangeNotifierProvider(
      builder: (_) => homePageModel,
      child: Consumer<HomePageModel>(
        builder: (__, model, child) => model.busy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
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
                  Column(
                    children: <Widget>[
                      ComicCoverList(
                        comicCovers: model.newComicCovers,
                        choosedComic: choosedComic,
                      ),
                    ],
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
                  Column(
                    children: <Widget>[
                      ComicCoverList(
                        comicCovers: model.maleComicCovers,
                        choosedComic: choosedComic,
                      ),
                    ],
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
                  Column(
                    children: <Widget>[
                      ComicCoverList(
                        comicCovers: model.femaleComicCovers,
                        choosedComic: choosedComic,
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
