import 'package:flutter/material.dart';

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[],
      ),
    );
  }
}

// class FilterListButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ResponsiveGridRow(
//                   children: [
//                     ResponsiveGridCol(
//                       sm: 12,
//                       xs: 12,
//                       md: 12,
//                       lg: 3,
//                       xl: 3,
//                       child: Center(
//                         child: Hero(
//                           tag: widget.idComic,
//                           child: CardImage(
//                             imageLink: model.comicDetail.imageLink,
//                           ),
//                         ),
//                       ),
//                     ),
//                     ResponsiveGridCol(
//                       sm: 12,
//                       xs: 12,
//                       md: 12,
//                       lg: 9,
//                       xl: 9,
//                       child: ComicInfo(
//                         comic: model.comicDetail,
//                         read: () {
//                           onReading(model.chapters);
//                         },
//                         follow: onFollowing,
//                         like: onLiking,
//                         findComicByType: onFindComicByType,
//                       ),
//                     ),
//                   ],
//                 );
//   }
// }

// class FilterListDropdown extends StatefulWidget {
//   @override
//   _FilterListDropdownState createState() => _FilterListDropdownState();
// }

// class _FilterListDropdownState extends State<FilterListDropdown> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(

//     );
//   }
// }
