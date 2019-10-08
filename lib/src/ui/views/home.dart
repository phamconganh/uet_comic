import 'package:flutter/cupertino.dart';
import 'package:uet_comic/src/core/models/comic_cover.dart';
import 'package:uet_comic/src/ui/widgets/comic_cover.dart';
// import 'package:uet_comic/src/ui/widgets/comic_cover.dart';
import 'package:uet_comic/src/ui/widgets/comics.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final comicCover = ComicCover(
      name: "Test asdasd asdasdasd adasdasd asdasdad adasdasda",
      lastUpdate: DateTime.now(),
      lastChapter: 1,
      imageLink:
          "http://i.mangaqq.com/ebook/190x247/hanh-trinh-hau-tan-the_1555066727.jpg?thang=t2123",
    );
    final comicCoverWidget = ComicCoverWidget(
      comicCover: comicCover,
    );
    // return ListView(
    //   children: [
    //     ComicsWidget(
    //       comicCoverWidgets: [
    //         ComicCoverWidget(
    //           comicCover: comicCover,
    //         ),
    //       ],
    //     ),
    //   ],
    // );
    return ComicsWidget(
      comicCoverWidgets: [
        comicCoverWidget,
        comicCoverWidget,
        comicCoverWidget,
        comicCoverWidget
      ],
    );
  }
}
