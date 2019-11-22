import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uet_comic/src/core/models/comic_cover.dart';
import 'package:uet_comic/src/ui/shared/type_def.dart';
import 'package:uet_comic/src/ui/widgets/images.dart';
import 'package:uet_comic/src/ui/widgets/responsive_grid.dart';

class ComicCoverList extends StatelessWidget {
  final List<ComicCover> comicCovers;
  final ChooseComicCover choosedComic;
  final bool isDownloaded;
  final String part;

  ComicCoverList({
    Key key,
    @required this.comicCovers,
    @required this.part,
    this.isDownloaded,
    this.choosedComic,
  })  : assert(comicCovers != null),
        assert(part != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveGridList(
      desiredItemWidth: 100,
      minSpacing: 10,
      children: List.generate(
        comicCovers.length,
        (index) => InkWell(
          onTap: () {
            if (choosedComic != null) {
              choosedComic(comicCovers[index], part);
            }
          },
          child: ComicCoverItem(
            comicCover: comicCovers[index],
            isDownloaded: isDownloaded,
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

  ComicCoverItem({
    Key key,
    @required this.comicCover,
    @required this.part,
    this.isDownloaded,
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
        HeroImage(
          tag: buildTagFromIdAndPart(
            comicCover.id,
            part,
          ),
          imageLink: comicCover.imageLink,
          isDownloaded: isDownloaded,
        ),
        Row(
          children: <Widget>[
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
            IconButton(
              icon: Icon(
                Icons.delete_forever,
                color: Colors.red,
              ),
              onPressed: null,
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
