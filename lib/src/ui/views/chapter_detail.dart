import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uet_comic/src/core/models/chapter.dart';
import 'package:uet_comic/src/core/view_models/widgets/chapter.dart';

class ChapterDetailPage extends StatefulWidget {
  final List<Chapter> chapters;
  final String idChapter;

  ChapterDetailPage({Key key, this.chapters, this.idChapter}) : super(key: key);

  @override
  _ChapterDetailPageState createState() => _ChapterDetailPageState();
}

class _ChapterDetailPageState extends State<ChapterDetailPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Đọc truyện"),
      ),

    );
  }
}
