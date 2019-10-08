import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uet_comic/src/ui/widgets/comic_cover.dart';

class ComicsWidget extends StatelessWidget {
  final List<ComicCoverWidget> comicCoverWidgets;
  final String title;
  final IconData iconData;
  final Color colorTitle;

  ComicsWidget(
      {Key key,
      @required this.comicCoverWidgets,
      this.title,
      this.iconData,
      this.colorTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = size.height;
    final double itemWidth = size.width;
    double scale = itemHeight/itemWidth;
    if(scale > 1) scale = 1/scale;

    final grid = GridView.count(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.
      crossAxisCount: 2,
      // childAspectRatio: (itemHeight/itemWidth),
      childAspectRatio: scale,
      padding: EdgeInsets.all(16.0),
      // childAspectRatio: 8.0 / 9.0,
      children: comicCoverWidgets,
    );
    return grid;
    // return title != null
    //     ? Container(
    //         child: Column(
    //           children: <Widget>[
    //             ListTile(
    //               leading: iconData != null
    //                   ? Icon(
    //                       iconData,
    //                       color: this.colorTitle ?? Colors.blue,
    //                     )
    //                   : null,
    //               title: Text(
    //                 title,
    //                 style: TextStyle(color: this.colorTitle ?? Colors.black),
    //               ),
    //             ),
    //             grid,
    //           ],
    //         ),
    //       )
    //     : Container(
    //         child: Column(
    //           children: <Widget>[
    //             grid,
    //           ],
    //         ),
    //       );
  }
}
