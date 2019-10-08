import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uet_comic/src/core/models/comic_cover.dart';

class ComicCoverWidget extends StatelessWidget {
  final ComicCover comicCover;
  final double imageAspectRatio;
  static final kTextBoxHeight = 65.0;

  ComicCoverWidget(
      {Key key, @required this.comicCover, this.imageAspectRatio: 33 / 49})
      : assert(comicCover != null),
        assert(imageAspectRatio == null || imageAspectRatio > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          child: Card(
            // color: Colors.black,
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Stack(
              children: <Widget>[
                Image.network(
                  comicCover.imageLink,
                  fit: BoxFit.fill,
                ),
                // TopNoTiceWidget(text: "${comicCover.lastUpdate}"),
                TopNoTiceWidget(text: "11 phut truoc"),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            margin: EdgeInsets.all(10),
          ),
          width: 150,
        ),
        SizedBox(
          child: Column(
            children: <Widget>[
              Text(
                comicCover.name,
                style: theme.textTheme.caption,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text(
                "Chuong ${comicCover.lastChapter}",
                style: theme.textTheme.caption,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
          width: 100,
        )
      ],
    );
  }
}

class TopNoTiceWidget extends StatelessWidget {
  final String text;
  final Color color;
  final double maxWidth;
  final bool isFlash;

  TopNoTiceWidget(
      {Key key, @required this.text, this.color, this.maxWidth, this.isFlash})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    // final Size size = MediaQuery.of(context).size;

    final container = Container(
      alignment: Alignment.center,
      height: 25,
      constraints: BoxConstraints(
        minWidth: 10,
        maxWidth: (maxWidth != null && maxWidth > 50 && maxWidth < 100)
            ? maxWidth
            : 100,
      ),
      padding: EdgeInsets.only(left: 5, right: 5),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: color ?? theme.buttonColor,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Text(
        text,
        textAlign: TextAlign.start,
        overflow: TextOverflow.ellipsis,
      ),
    );
    return this.isFlash != null && this.isFlash
        ? AnimatedContainer(
            // transform: ,
            duration: Duration(milliseconds: 1),
            child: container,
          )
        : container;
  }
}
