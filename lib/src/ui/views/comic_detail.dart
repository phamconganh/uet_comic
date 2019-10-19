import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uet_comic/src/core/view_models/views/comic_detail.dart';
import 'package:uet_comic/src/ui/widgets/comic_cover.dart';
import 'package:uet_comic/src/ui/widgets/comic_detail.dart';
import 'package:uet_comic/src/ui/widgets/responsive_grid.dart';

class ComicDetailPage extends StatefulWidget {
  final String idComic;

  ComicDetailPage({Key key, this.idComic}) : super(key: key);

  @override
  _ComicDetailPageState createState() => _ComicDetailPageState();
}

class _ComicDetailPageState extends State<ComicDetailPage> {
  ComicDetailPageModel comicDetailPageModel;

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
    if (comicDetailPageModel == null) {
      comicDetailPageModel = ComicDetailPageModel();
      comicDetailPageModel.fetchComicDetail(widget.idComic);
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
                ResponsiveGridRow(
                  children: [
                    ResponsiveGridCol(
                      sm: 6,
                      xs: 6,
                      md: 3,
                      lg: 4,
                      xl: 5,
                      // lg: 12,
                      child: Hero(
                        tag: widget.idComic,
                        child: Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Image.network(
                            model.comicDetail.imageLink,
                            fit: BoxFit.fill,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          margin: EdgeInsets.all(10),
                        ),
                      ),
                    ),
                    ResponsiveGridCol(
                      // xs: 6,
                      // md: 3,
                      child: Container(
                        height: 100,
                        alignment: Alignment(0, 0),
                        color: Colors.green,
                        child: Text("xs : 6 \r\nmd : 3"),
                      ),
                    ),
                  ],
                ),
                const ListTile(
                  leading: Icon(Icons.list, color: Colors.orange),
                  title: Text(
                    "Danh sách chương",
                    style: TextStyle(color: Colors.orange),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ChapterList(
                  idComic: widget.idComic,
                ),
                RaisedButton(
                  onPressed: () {},
                  child: Text('Load more'),
                ),
                const ListTile(
                  leading: Icon(Icons.featured_play_list, color: Colors.purple),
                  title: Text(
                    "Cùng thể loại",
                    style: TextStyle(color: Colors.purple),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ComicCoverList(
                  comicCovers: model.sameComic,
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
