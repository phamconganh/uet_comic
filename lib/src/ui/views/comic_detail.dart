import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:uet_comic/src/core/models/chapter.dart';
import 'package:uet_comic/src/core/models/comic.dart';
import 'package:uet_comic/src/core/services/local_file.dart';
import 'package:uet_comic/src/core/view_models/shared/chapter_dao.dart';
import 'package:uet_comic/src/core/view_models/shared/comic_dao.dart';
import 'package:uet_comic/src/core/view_models/shared/follow_dao.dart';
import 'package:uet_comic/src/core/view_models/shared/like_dao.dart';
import 'package:uet_comic/src/core/view_models/views/base.dart';
import 'package:uet_comic/src/core/view_models/views/comic_detail.dart';
import 'package:uet_comic/src/core/view_models/views/filter.dart';
import 'package:uet_comic/src/ui/shared/theme.dart';
import 'package:uet_comic/src/ui/views/chapter_detail.dart';
import 'package:uet_comic/src/ui/widgets/dialogs.dart';
import 'package:uet_comic/src/ui/widgets/chapter.dart';
import 'package:uet_comic/src/ui/widgets/images.dart';
import 'package:uet_comic/src/ui/widgets/responsive_grid.dart';
import 'package:uet_comic/src/ui/widgets/type.dart';

class ComicDetailPage extends StatefulWidget {
  final String part;

  ComicDetailPage({Key key, @required this.part}) : super(key: key);

  @override
  _ComicDetailPageState createState() => _ComicDetailPageState();
}

class _ComicDetailPageState extends State<ComicDetailPage> {
  ComicDetailPageModel model;
  FollowDao followDao;
  LikeDao likeDao;

  void onReadIndexChapter(List<Chapter> chapters, int index) {
    if (chapters.length == 0) return;
    if (index != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => ChapterDetailPage(
            indexChapter: chapters.length - index - 1,
            chapters: chapters.reversed.toList(),
            comic: model.comicDetail,
            isDownloaded: model.isDownloaded,
          ),
        ),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => ChapterDetailPage(
            indexChapter: 0,
            chapters: chapters.reversed.toList(),
            comic: model.comicDetail,
            isDownloaded: model.isDownloaded,
          ),
        ),
      );
    }
    model.read();
  }

  void follow() {
    model.follow();
    followDao.add(model.comicDetail.id);
  }

  void unFollow() {
    model.unfollow();
    followDao.remove(model.comicDetail.id);
  }

  void like() {
    model.like();
    likeDao.add(model.comicDetail.id);
  }

  void dislike() {
    model.dislike();
    likeDao.remove(model.comicDetail.id);
  }

  void onLoadMoreChapter() {
    // print("onLoadMoreChapter comic id ${widget.idComic}");
  }

  void onFindComicByType(String idType) {
    FilterPageModel filterPageModel = Provider.of(context);
    filterPageModel.clear();
    filterPageModel.setIdType(idType);
    filterPageModel.fetchFilter();
    Provider.of<BasePageModel>(context).slideToPage(1);
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  Future<void> downloadAllChapter() async {
    bool confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return Confirm(
          header: 'Tải tất cả chương trong truyện',
          message: 'Bạn muốn tải tất cả các chương trong truyện?',
          okText: 'Tải',
          cancelText: 'Hủy',
        );
      },
    );
    if (confirm == true) {
      Comic downloadedComic = Comic.fromMap(model.comicDetail.toMap());
      List<Chapter> chapters = model.chapters;
      model.setIsDownloading(true);
      if (downloadedComic.id == model.comicDetail.id) {
        model.setPercentDownloaded(0);
      }
      try {
        String imageLink = await LocalFileService.instance.saveImage(
            url: downloadedComic.imageLink, comicFolder: downloadedComic.id);

        downloadedComic.imageLink = imageLink;
        downloadedComic.isInProcess = true;

        ComicDao comicDao = Provider.of(context);
        int key = await comicDao.add(downloadedComic);

        int total = 0;
        for (var i = 0; i < chapters.length; i++) {
          total += chapters[i].images.length;
        }
        int count = 0;

        ChapterDao chapterDao = Provider.of(context);
        List<Chapter> downloadedChapters = [];

        for (var i = 0; i < chapters.length; i++) {
          Chapter chapter = chapters[i];
          Chapter downloadedChapter = Chapter.fromMap(chapter.toMap());
          downloadedChapter.images = [];
          for (var j = 0; j < chapter.images.length; j++) {
            var image = chapter.images[j];
            print("Start download $image");
            try {
              image = await LocalFileService.instance
                  .saveImage(url: image, comicFolder: downloadedComic.id);
              downloadedChapter.images.add(image);
            } catch (e) {
              print("Error download $image");
            }
            count++;
            double percent = count / total;
            if (downloadedComic.id == model.comicDetail.id) {
              model.setPercentDownloaded(percent);
            }
          }
          if (downloadedChapter.images.isNotEmpty &&
              chapter.images.isNotEmpty) {
            chapterDao.add(downloadedChapter);
            downloadedChapters.add(downloadedChapter);
          }
        }

        downloadedComic.isInProcess = false;
        comicDao.unProcess(key, downloadedComic.id);
        // check xem co phai van dang o trong trang truyen dang tai hay khong
        if (downloadedComic.id == model.comicDetail.id) {
          model.setComicDetail(downloadedComic);
          model.setChapters(downloadedChapters);
          model.setDownloaded(true);
        }
      } catch (e) {
        print("Error download ${downloadedComic.id} + ${e.toString()}");
      }
      if (downloadedComic.id == model.comicDetail.id) {
        model.setIsDownloading(false);
        model.setPercentDownloaded(0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (model == null) {
      model = Provider.of(context);
    }
    if (followDao == null) {
      followDao = Provider.of(context);
    }
    if (likeDao == null) {
      likeDao = Provider.of(context);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết truyện"),
      ),
      body: Consumer<ComicDetailPageModel>(
        builder: (_, model, __) {
          return model.busy
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      const Divider(),
                      model.comicDetail == null
                          ? Container()
                          : ResponsiveGridRow(
                              children: [
                                ResponsiveGridCol(
                                  sm: 12,
                                  xs: 12,
                                  md: 12,
                                  lg: 3,
                                  xl: 3,
                                  child: Center(
                                    child: ComicCoverImage(
                                      comicCover: model.comicDetail,
                                      part: widget.part,
                                      isDownloaded: model.isDownloaded,
                                    ),
                                  ),
                                ),
                                ResponsiveGridCol(
                                  sm: 12,
                                  xs: 12,
                                  md: 12,
                                  lg: 9,
                                  xl: 9,
                                  child: _buildComicInfo(),
                                ),
                              ],
                            ),
                      Card(
                        elevation: 5,
                        margin: const EdgeInsets.all(5.0),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 5,
                            right: 10,
                            left: 10,
                            bottom: 15,
                          ),
                          child: Column(
                            children: <Widget>[
                              _buildTitleChapters(),
                              model.isDownloading
                                  ? CircularPercentIndicator(
                                      radius: 30,
                                      lineWidth: 2,
                                      percent: model.percentDownloaded,
                                      center: Text(
                                        "${(model.percentDownloaded * 100).round()} %",
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      progressColor: Colors.green,
                                      // animation: true,
                                    )
                                  : Container(),
                              model.chapters.length == 0 &&
                                      model.chapters == null
                                  ? Container()
                                  : Container(
                                      child: ChapterList(
                                        chapters: model.chapters,
                                        onReadIndexChapter: (index) {
                                          onReadIndexChapter(
                                              model.chapters, index);
                                        },
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }

  Widget _buildTitleChapters() {
    return ListTile(
      leading: const Icon(
        Icons.list,
        color: Colors.orange,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text(
            "Danh sách chương",
            style: TextStyle(color: Colors.orange),
            overflow: TextOverflow.ellipsis,
          ),
          model.isDownloaded || model.comicDetail == null
              ? Container()
              : IconButton(
                  icon: const Icon(Icons.cloud_download, color: Colors.green,),
                  onPressed: downloadAllChapter,
                )
        ],
      ),
    );
  }

  Widget _buildComicInfo() {
    return Consumer<ComicDetailPageModel>(
      builder: (_, model, __) {
        String state =
            model.comicDetail.state == 0 ? "Chưa hoàn thành" : "Đã hoàn thành";

        final Widget readFirstButton = RaisedButton.icon(
          icon: const Icon(Icons.book),
          label: const Text(
            "Đọc từ đầu",
            overflow: TextOverflow.ellipsis,
          ),
          onPressed: () {
            onReadIndexChapter(model.chapters, null);
          },
          shape: boderButton,
        );

        final Widget unfollowButton = RaisedButton.icon(
          icon: const Icon(FontAwesomeIcons.heartBroken),
          label: const Text(
            "Bỏ theo dõi",
            overflow: TextOverflow.ellipsis,
          ),
          onPressed: unFollow,
          shape: boderButton,
        );

        final Widget followButton = RaisedButton.icon(
          icon: const Icon(FontAwesomeIcons.heart),
          label: const Text(
            "Theo dõi",
            overflow: TextOverflow.ellipsis,
          ),
          onPressed: follow,
          shape: boderButton,
        );

        final Widget likeButton = RaisedButton.icon(
          icon: const Icon(Icons.thumb_up),
          label: const Text(
            "Thích",
            overflow: TextOverflow.ellipsis,
          ),
          onPressed: like,
          shape: boderButton,
        );

        final Widget unLikeButton = RaisedButton.icon(
          icon: const Icon(Icons.thumb_down),
          label: const Text(
            "Bỏ thích",
            overflow: TextOverflow.ellipsis,
          ),
          onPressed: dislike,
          shape: boderButton,
        );

        return Card(
          elevation: 2,
          margin: const EdgeInsets.all(5.0),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 5,
              bottom: 15,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.book,
                    color: Colors.blue,
                  ),
                  title: Text(
                    model.comicDetail.name,
                    style: Theme.of(context).textTheme.headline,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: {0: FractionColumnWidth(0.35)},
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                            child: Text(
                              "Tác giả:",
                              style: Theme.of(context).textTheme.body2,
                            ),
                          ),
                          TableCell(
                            child: Center(
                              child: Text(
                                "${model.comicDetail?.author?.name}",
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.body2,
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Text(
                              "Tình trạng:",
                              style: Theme.of(context).textTheme.body2,
                            ),
                          ),
                          TableCell(
                            child: Center(
                              child: Text(
                                "$state",
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,
                    children: [
                      const Icon(
                        Icons.thumb_up,
                        color: Colors.blue,
                      ),
                      Text(' ${model.comicDetail.like}  '),
                      const Icon(
                        FontAwesomeIcons.heart,
                        color: Colors.pink,
                      ),
                      Text(' ${model.comicDetail.follow}  '),
                      const Icon(
                        Icons.remove_red_eye,
                        color: Colors.pink,
                      ),
                      Text(' ${model.comicDetail.view}')
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 10, bottom: 12),
                  child: ExpandablePanel(
                    header: Text(
                      "Nội dung truyện",
                      style: Theme.of(context).textTheme.body2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    collapsed: Text(
                      model.comicDetail.content,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    expanded: Text(
                      model.comicDetail.content,
                      softWrap: true,
                    ),
                    tapHeaderToExpand: true,
                    tapBodyToCollapse: true,
                    hasIcon: true,
                  ),
                ),
                TypeList(
                  types: model.comicDetail.types,
                  findComicByType: onFindComicByType,
                ),
                Container(
                  width: double.infinity,
                  child: Wrap(
                    spacing: 5.0,
                    alignment: WrapAlignment.center,
                    children: <Widget>[
                      readFirstButton,
                      model.isFollowed ? unfollowButton : followButton,
                      model.isLiked ? unLikeButton : likeButton,
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
