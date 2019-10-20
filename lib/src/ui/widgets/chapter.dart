import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uet_comic/src/core/models/chapter.dart';

class ChapterList extends StatelessWidget {
  final List<Chapter> chapters;

  ChapterList({Key key, this.chapters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: chapters.length,
      reverse: true,
      itemBuilder: (BuildContext context, int index) {
        return ChapterItem(
          chapter: chapters[index],
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}

class ChapterItem extends StatelessWidget {
  final Chapter chapter;

  ChapterItem({Key key, this.chapter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("Chuong ${chapter.name}"),
          Text("18/10/2019"),
        ],
      ),
      onTap: () {},
    );
  }
}
