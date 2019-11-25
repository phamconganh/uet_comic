import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uet_comic/src/core/models/comic_cover.dart';
import 'package:uet_comic/src/ui/shared/type_def.dart';
import 'package:uet_comic/src/ui/widgets/images.dart';
import 'package:uet_comic/src/ui/widgets/responsive_grid.dart';

class ComicCoverList extends StatelessWidget {
  final List<ComicCover> comicCovers;
  final ChooseComicCoverPart onChoosedComic;
  final ChooseComicCover onDeleteComic;
  final bool isDownloaded;
  final String part;

  ComicCoverList(
      {Key key,
      @required this.comicCovers,
      @required this.part,
      this.isDownloaded,
      this.onChoosedComic,
      this.onDeleteComic})
      : assert(comicCovers != null),
        assert(part != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveGridList(
      desiredItemWidth: 100,
      minSpacing: 10,
      children: List.generate(
        comicCovers.length,
        (index) => GestureDetector(
          onTap: () {
            if (onChoosedComic != null) {
              onChoosedComic(comicCovers[index], part);
            }
          },
          onLongPress: () {
            // showMenu(
            //   position: RelativeRect.fromLTRB(10, 10, 10, 10),
            //   // onSelected: () {},
            //   items: <PopupMenuEntry>[
            //     PopupMenuItem(
            //       value: 0,
            //       child: Row(
            //         children: <Widget>[
            //           Icon(Icons.delete),
            //           Text("Delete"),
            //         ],
            //       ),
            //     )
            //   ],
            //   context: context,
            // );
          },
          child: ComicCoverItem(
            comicCover: comicCovers[index],
            isDownloaded: isDownloaded,
            onDeleteComic: onDeleteComic,
            part: part,
          ),
        ),
      ),
    );
  }
}

class ComicCoverItem extends StatelessWidget {
  final ComicCover comicCover;
  final String part;
  final isDownloaded;
  final ChooseComicCover onDeleteComic;

  ComicCoverItem({
    Key key,
    @required this.comicCover,
    @required this.part,
    this.isDownloaded,
    this.onDeleteComic,
  })  : assert(comicCover != null),
        assert(part != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Stack(
          alignment: AlignmentDirectional.topEnd,
          children: <Widget>[
            ComicCoverImage(
              comicCover: comicCover,
              part: part,
              isDownloaded: isDownloaded,
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: ClipOval(
                  child: Container(
                    color: Colors.white,
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ),
            onDeleteComic != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: SizedBox(
                          child: FloatingActionButton(
                            heroTag: comicCover.id +
                                "_" +
                                part +
                                "_sync_float_action",
                            backgroundColor: Colors.white,
                            elevation: 10,
                            child: Icon(
                              Icons.sync,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              onDeleteComic(comicCover);
                            },
                            tooltip: "Xóa truyện",
                          ),
                          width: 30,
                          height: 30,
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: SizedBox(
                          child: FloatingActionButton(
                            heroTag: comicCover.id +
                                "_" +
                                part +
                                "_delete_float_action",
                            backgroundColor: Colors.white,
                            elevation: 10,
                            child: Icon(
                              Icons.delete_forever,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              onDeleteComic(comicCover);
                            },
                            tooltip: "Xóa truyện",
                          ),
                          width: 30,
                          height: 30,
                        ),
                      ),
                      // GestureDetector(
                      //   behavior: HitTestBehavior.opaque,
                      //   child: SizedBox(
                      //     child: FloatingActionButton(
                      //       heroTag:
                      //           comicCover.id + "_" + part + "_reload_float_action",
                      //       backgroundColor: Colors.white,
                      //       elevation: 10,
                      //       child: Icon(
                      //         Icons.delete_forever,
                      //         color: Colors.red,
                      //       ),
                      //       onPressed: () {
                      //         onDeleteComic(comicCover);
                      //       },
                      //       tooltip: "Xóa truyện",
                      //     ),
                      //     width: 30,
                      //     height: 30,
                      //   ),
                      // ),
                    ],
                  )
                : Container(),
          ],
        ),
        Column(
          children: <Widget>[
            Text(
              comicCover.name,
              style: theme.textTheme.caption,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            Text(
              "${comicCover.lastChapter}",
              style: theme.textTheme.caption,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ],
    );
  }
}

// class TopNoTiceWidget extends StatelessWidget {
//   final String text;
//   final Color color;
//   final double maxWidth;
//   final bool isFlash;

//   TopNoTiceWidget(
//       {Key key, @required this.text, this.color, this.maxWidth, this.isFlash})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final ThemeData theme = Theme.of(context);
//     // final Size size = MediaQuery.of(context).size;

//     final container = Container(
//       alignment: Alignment.center,
//       height: 25,
//       constraints: BoxConstraints(
//         minWidth: 10,
//         maxWidth: (maxWidth != null && maxWidth > 50 && maxWidth < 100)
//             ? maxWidth
//             : 100,
//       ),
//       padding: EdgeInsets.only(left: 5, right: 5),
//       margin: EdgeInsets.all(5),
//       decoration: BoxDecoration(
//         color: color ?? theme.buttonColor,
//         borderRadius: BorderRadius.all(Radius.circular(5.0)),
//       ),
//       child: Text(
//         text,
//         textAlign: TextAlign.start,
//         overflow: TextOverflow.ellipsis,
//       ),
//     );
//     return this.isFlash != null && this.isFlash
//         ? AnimatedContainer(
//             // transform: ,
//             duration: Duration(milliseconds: 1),
//             child: container,
//           )
//         : container;
//   }
// }
