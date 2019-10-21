import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uet_comic/src/core/models/chapter.dart';
import 'package:uet_comic/src/core/view_models/views/comic_detail.dart';
import 'package:uet_comic/src/ui/views/chapter_detail.dart';
import 'package:uet_comic/src/ui/widgets/card_image.dart';
import 'package:uet_comic/src/ui/widgets/chapter.dart';
import 'package:uet_comic/src/ui/widgets/comic_cover.dart';
import 'package:uet_comic/src/ui/widgets/comic_info.dart';
import 'package:uet_comic/src/ui/widgets/responsive_grid.dart';

class ComicDetailPage extends StatefulWidget {
  final String idComic;

  ComicDetailPage({Key key, @required this.idComic}) : super(key: key);

  @override
  _ComicDetailPageState createState() => _ComicDetailPageState();
}

class _ComicDetailPageState extends State<ComicDetailPage> {
  ComicDetailPageModel comicDetailPageModel;

  void choosedComic(String idComic) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => ComicDetailPage(
          // idComic: idComic,
          idComic: "99",
        ),
      ),
    );
  }

  void onReading(List<Chapter> chapters) {
    if(chapters.length == 0) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => ChapterDetailPage(
          idChapter: chapters[0].id,
          chapters: chapters,
        ),
      ),
    );
  }

  void onFollowing() {
    print("Follow comic id ${widget.idComic}");
  }

  void onLiking() {
    print("Like comic id ${widget.idComic}");
  }

  void onLoadMoreChapter() {
    print("onLoadMoreChapter comic id ${widget.idComic}");
  }

  void onFindComicByType(String idType) {
    print("onFindComicByType comic id ${widget.idComic}");
  }

  @override
  Widget build(BuildContext context) {
    print(widget.idComic);
    if (comicDetailPageModel == null) {
      comicDetailPageModel = ComicDetailPageModel();
      comicDetailPageModel.fetchComicDetail(widget.idComic);
      comicDetailPageModel.fetchChapters(widget.idComic);
      comicDetailPageModel.fetchSameComics();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết truyện"),
      ),
      body: ChangeNotifierProvider(
        builder: (_) => comicDetailPageModel,
        child: Consumer<ComicDetailPageModel>(builder: (__, model, child) {
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Divider(),
                ResponsiveGridRow(
                  children: [
                    ResponsiveGridCol(
                      sm: 12,
                      xs: 12,
                      md: 12,
                      lg: 3,
                      xl: 3,
                      child: Center(
                        child: Hero(
                          tag: widget.idComic,
                          child: CardImage(
                            imageLink: model.comicDetail.imageLink,
                          ),
                        ),
                      ),
                    ),
                    ResponsiveGridCol(
                      sm: 12,
                      xs: 12,
                      md: 12,
                      lg: 9,
                      xl: 9,
                      child: ComicInfo(
                        comic: model.comicDetail,
                        read: () {
                          onReading(model.chapters);
                        },
                        follow: onFollowing,
                        like: onLiking,
                        findComicByType: onFindComicByType,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                const ListTile(
                  leading: const Icon(
                    Icons.list,
                    color: Colors.orange,
                  ),
                  title: const Text(
                    "Danh sách chương",
                    style: TextStyle(color: Colors.orange),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ChapterList(
                  chapters: model.chapters,
                ),
                RaisedButton(
                  onPressed: () {},
                  child: Text('Load more'),
                ),
                const Divider(),
                const ListTile(
                  leading: const Icon(
                    Icons.featured_play_list,
                    color: Colors.purple,
                  ),
                  title: const Text(
                    "Cùng thể loại",
                    style: TextStyle(color: Colors.purple),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ComicCoverList(
                  comicCovers: model.sameComics,
                  choosedComic: choosedComic,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
