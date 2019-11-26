import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:provider/provider.dart';
import 'package:uet_comic/src/core/models/chapter.dart';
import 'package:uet_comic/src/core/models/comic.dart';
import 'package:uet_comic/src/core/view_models/views/base.dart';
import 'package:uet_comic/src/core/view_models/views/chapter_detail.dart';
import 'package:uet_comic/src/ui/widgets/images.dart';

class ChapterDetailPage extends StatefulWidget {
  final List<Chapter> chapters;
  final int indexChapter;
  final Comic comic;
  final bool isDownloaded;

  ChapterDetailPage({
    Key key,
    @required this.chapters,
    @required this.indexChapter,
    this.comic,
    this.isDownloaded,
  }) : super(key: key);

  @override
  _ChapterDetailPageState createState() => _ChapterDetailPageState();
}

class _ChapterDetailPageState extends State<ChapterDetailPage> {
  ChapterDetailPageModel chapterDetailPageModel;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    chapterDetailPageModel = ChapterDetailPageModel();
    chapterDetailPageModel.setChaptersWithIndex(
        widget.indexChapter, widget.chapters);
    super.initState();
  }

  void goHome() {
    Provider.of<BasePageModel>(context).slideToPage(0);
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  void reportChapter() async {
    final MailOptions mailOptions = MailOptions(
      body: 'Lý do lỗi:',
      subject:
          'Lỗi chương ${chapterDetailPageModel.chapter.name} trong truyện ${widget.comic != null ? widget.comic.name : ''}',
      recipients: ['uetcomic@gmail.com'],
      // cc: ['cc@example.com'],
      // bcc: ['bcc@example.com'],
      isHTML: true,
    );
    await FlutterMailer.send(mailOptions);
  }

  void changeLight() {
    print("Change light");
  }

  void like() {
    print("like");
  }

  void nextChapter() {
    _scrollController.jumpTo(0);
    chapterDetailPageModel.setIndex(chapterDetailPageModel.index + 1);
  }

  void previousChapter() {
    _scrollController.jumpTo(0);
    chapterDetailPageModel.setIndex(chapterDetailPageModel.index - 1);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: chapterDetailPageModel,
      child: Consumer<ChapterDetailPageModel>(
        builder: (__, model, ___) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Đọc truyện"),
            ),
            body: ListView(
              controller: _scrollController,
              children: List.generate(
                model.chapter.images.length,
                (index) {
                  return Padding(
                    child: SafeImage(
                      imageLink: model.chapter.images[index],
                      isDownloaded: widget.isDownloaded,
                    ),
                    padding: const EdgeInsets.only(
                      left: 5.0,
                      right: 5.0,
                    ),
                  );
                },
              ),
            ),
            bottomNavigationBar: _buildChapterBar(),
          );
        },
      ),
    );
  }

  Widget _buildChapterBar() {
    return Container(
      child: ConstrainedBox(
        constraints: new BoxConstraints(
          minHeight: 45,
          maxHeight: 50,
        ),
        child: FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.home),
                onPressed: goHome,
              ),
              // IconButton(
              //   icon: Icon(Icons.warning),
              //   onPressed: reportChapter,
              // ),
              IconButton(
                icon: Icon(Icons.navigate_before),
                onPressed:
                    chapterDetailPageModel.isStart ? null : previousChapter,
              ),
              DropdownButton<int>(
                value: chapterDetailPageModel.index,
                items: List.generate(chapterDetailPageModel.chapters.length,
                    (index) {
                  return DropdownMenuItem(
                    child: Center(
                      child: Text(
                          '${chapterDetailPageModel.chapters[index].name}'),
                    ),
                    value: index,
                  );
                }),
                onChanged: (int value) {
                  if (value != chapterDetailPageModel.index) {
                    chapterDetailPageModel.setIndex(value);
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.navigate_next),
                onPressed: chapterDetailPageModel.isEnd ? null : nextChapter,
              ),
              // IconButton(
              //   icon: Icon(FontAwesomeIcons.lightbulb),
              //   onPressed: changeLight,
              // ),
              // IconButton(
              //   icon: Icon(FontAwesomeIcons.heart),
              //   onPressed: like,
              // ),
              IconButton(
                icon: Icon(Icons.warning),
                onPressed: reportChapter,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
