import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uet_comic/src/core/models/chapter.dart';
import 'package:uet_comic/src/ui/shared/type_def.dart';

class ChapterList extends StatelessWidget {
  final List<Chapter> chapters;
  final IntCallback onReadIndexChapter;

  ChapterList({
    Key key,
    @required this.chapters,
    this.onReadIndexChapter,
  })  : assert(chapters != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: chapters.length,
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

class ChapterItem extends StatelessWidget {
  final Chapter chapter;

  ChapterItem({
    Key key,
    @required this.chapter,
  })  : assert(chapter != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    String lastUpdate = chapter.lastUpdate != null
        ? "${chapter.lastUpdate.day.toString().padLeft(2, '0')}-${chapter.lastUpdate.month.toString().padLeft(2, '0')}-${chapter.lastUpdate.year.toString()}"
        : '18/11/19';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text("${chapter.name}"),
        Text(lastUpdate),
      ],
    );
  }
}
