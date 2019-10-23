import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:uet_comic/src/core/models/chapter.dart';
import 'package:uet_comic/src/core/view_models/views/chapter_detail.dart';
import 'package:uet_comic/src/ui/widgets/bottom_chapter_bar.dart';

class ChapterDetailPage extends StatefulWidget {
  final List<Chapter> chapters;
  final String idChapter;

  ChapterDetailPage({Key key, this.chapters, this.idChapter}) : super(key: key);

  @override
  _ChapterDetailPageState createState() => _ChapterDetailPageState();
}

class _ChapterDetailPageState extends State<ChapterDetailPage> {
  ChapterDetailPageModel chapterDetailPageModel;

  @override
  void initState() {
    chapterDetailPageModel = ChapterDetailPageModel();
    chapterDetailPageModel.fetchChapterDetail(widget.idChapter);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Đọc truyện"),
      ),
      body: ChangeNotifierProvider(
        builder: (_) => chapterDetailPageModel,
        child: Consumer<ChapterDetailPageModel>(
          builder: (__, model, ___) {
            return ListView(
              children: List.generate(
                model.chapter.images.length,
                (index) {
                  return Padding(
                    child: Image.network(
                      model.chapter.images[index],
                      fit: BoxFit.fill,
                    ),
                    padding: const EdgeInsets.only(
                      left: 5.0,
                      right: 5.0,
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomChapterBar(
        chapters: widget.chapters,
      ),
    );
  }
}
