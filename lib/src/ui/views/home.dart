import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uet_comic/src/core/view_models/views/home.dart';
import 'package:uet_comic/src/ui/views/comic_detail.dart';
import 'package:uet_comic/src/ui/widgets/comic_cover.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  HomePageModel homePageModel;

  void choosedComic(String idComic) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => ComicDetailPage(
          idComic: idComic,
        ),
      ),
    );
  }

  Future<void> onLoadData() async {
    homePageModel.fetchNewComicCovers();
    homePageModel.fetchMaleComicCovers();
    homePageModel.fetchFemaleComicCovers();
    return;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if(homePageModel == null) {
      homePageModel = HomePageModel(comicService: Provider.of(context));
      onLoadData();
    }
    return RefreshIndicator(
      onRefresh: onLoadData,
      child: ChangeNotifierProvider(
        builder: (_) => homePageModel,
        child: Consumer<HomePageModel>(
          builder: (__, model, child) => ListView(
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
                          ),
                        ],
                      ),
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
