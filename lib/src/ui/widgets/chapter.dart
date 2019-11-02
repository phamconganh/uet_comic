import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:uet_comic/src/core/models/chapter.dart';
import 'package:uet_comic/src/ui/shared/type_def.dart';

class ChapterList extends StatelessWidget {
  final List<Chapter> chapters;
  final IntCallback onReadIndexChapter;

  ChapterList({Key key, @required this.chapters, this.onReadIndexChapter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: chapters.length,
      reverse: true,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          child: ChapterItem(
            chapter: chapters[index],
          ),
          onTap: () {
            if (onReadIndexChapter != null) {
              onReadIndexChapter(index);
            }
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}

final formatter = DateFormat('dd-mm-yy');

class ChapterItem extends StatelessWidget {
  final Chapter chapter;

  ChapterItem({Key key, @required this.chapter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text("Chuong ${chapter.name}"),
        Text(
            "${chapter.lastUpdate != null ? formatter.format(chapter.lastUpdate) : '18/11/19'}"),
      ],
    );
  }
}
