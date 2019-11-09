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

  void choosedComic(String data) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => ComicDetailPage(
          // idComic: idComic,
          idComic: "99",
        ),
      ),
    );
  }

  void onReadIndexChapter(List<Chapter> chapters, int index) {
    if (chapters.length == 0) return;
    if (index != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => ChapterDetailPage(
            indexChapter: index,
            chapters: chapters,
            comic: comicDetailPageModel.comicDetail,
          ),
        ),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => ChapterDetailPage(
            indexChapter: 0,
            chapters: chapters,
            comic: comicDetailPageModel.comicDetail,
          ),
        ),
      );
    }
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

  Future<void> downloadAllChapter() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tải tất cả chương trong truyện'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Bạn muốn tải tất cả các chương trong truyện?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Tải'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> onLoadData() async {
    comicDetailPageModel.fetchComicDetail(widget.idComic);
    comicDetailPageModel.fetchChapters(widget.idComic);
    comicDetailPageModel.fetchSameComics();
    return;
  }

  @override
  Widget build(BuildContext context) {
    if (comicDetailPageModel == null) {
      comicDetailPageModel = ComicDetailPageModel(
        comicService: Provider.of(context),
        chapterService: Provider.of(context),
        authorService: Provider.of(context),
        typeService: Provider.of(context),
      );
      onLoadData();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết truyện"),
      ),
      body: SingleChildScrollView(
        child: ChangeNotifierProvider(
          builder: (_) => comicDetailPageModel,
          child: Consumer<ComicDetailPageModel>(builder: (__, model, child) {
            return Column(
              children: <Widget>[
                const Divider(),
                Container(
                  child: model.isFetchingComicDetail
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ResponsiveGridRow(
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
                                  onReadIndexChapter(model.chapters, null);
                                },
                                follow: onFollowing,
                                like: onLiking,
                                findComicByType: onFindComicByType,
                              ),
                            ),
                          ],
                        ),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(
                    Icons.list,
                    color: Colors.orange,
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        "Danh sách chương",
                        style: TextStyle(color: Colors.orange),
                        overflow: TextOverflow.ellipsis,
                      ),
                      IconButton(
                        icon: const Icon(Icons.cloud_download),
                        onPressed: downloadAllChapter,
                      )
                    ],
                  ),
                ),
                Container(
                  child: model.isFetchingChapters
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ChapterList(
                          chapters: model.chapters,
                          onReadIndexChapter: (index) {
                            onReadIndexChapter(model.chapters, index);
                          },
                        ),
                ),
                // RaisedButton(
                //   onPressed: () {},
                //   child: Text('Load more'),
                // ),
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
                Container(
                  child: model.isFetchingSameComics
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ComicCoverList(
                          comicCovers: model.sameComics,
                          choosedComic: choosedComic,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
