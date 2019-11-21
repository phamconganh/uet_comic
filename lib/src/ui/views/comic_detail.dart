import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uet_comic/src/core/models/chapter.dart';
import 'package:uet_comic/src/core/services/local_file.dart';
import 'package:uet_comic/src/core/view_models/shared/comic_dao.dart';
import 'package:uet_comic/src/core/view_models/shared/follow_dao.dart';
import 'package:uet_comic/src/core/view_models/shared/like_dow.dart';
import 'package:uet_comic/src/core/view_models/views/base.dart';
import 'package:uet_comic/src/core/view_models/views/comic_detail.dart';
import 'package:uet_comic/src/core/view_models/views/filter.dart';
import 'package:uet_comic/src/ui/shared/theme.dart';
import 'package:uet_comic/src/ui/views/chapter_detail.dart';
import 'package:uet_comic/src/ui/widgets/alert.dart';
import 'package:uet_comic/src/ui/widgets/card_image.dart';
import 'package:uet_comic/src/ui/widgets/chapter.dart';
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
            indexChapter: index,
            chapters: chapters,
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
            chapters: chapters,
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
    if (confirm) {
      String imageLink = await LocalFileService.instance
          .saveImage(model.comicDetail.imageLink);
      model.comicDetail.imageLink = imageLink;
      model.setDownloaded(true);
      ComicDao comicDao = Provider.of(context);
      comicDao.add(model.comicDetail);
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
      body: SingleChildScrollView(
        child: Consumer<ComicDetailPageModel>(
          builder: (_, model, __) {
            return Column(
              children: <Widget>[
                const Divider(),
                Center(
                          child: CircularProgressIndicator(semanticsValue: "0.8",),
                        ),
                Container(
                  child: model.isFetchingComicDetail
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ResponsiveGridRow(
                          children: [
                            ResponsiveGridCol(
                              sm: 12,
                              xs: 12,
                              md: 12,
                              lg: 3,
                              xl: 3,
                              child: Center(
                                child: Hero(
                                  tag: model.comicDetail.id + "_" + widget.part,
                                  child: CardImage(
                                    imageLink: model.comicDetail.imageLink,
                                    isDownloaded: model.isDownloaded,
                                  ),
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
                ),
                const Divider(),
                _buildTitleChapters(),
                Container(
                  child: model.isFetchingChapters
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ChapterList(
                          chapters: model.chapters,
                          onReadIndexChapter: (index) {
                            onReadIndexChapter(model.chapters, index);
                          },
                        ),
                ),
                heightPadding,
              ],
            );
          },
        ),
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
          model.isDownloaded
              ? Container()
              : IconButton(
                  icon: const Icon(Icons.cloud_download),
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

        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                model.comicDetail.name,
                style: Theme.of(context).textTheme.headline,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              heightSpace,
              Text(
                "Tác giả: ${model.comicDetail?.author?.name}",
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                "Tình trạng: $state",
                overflow: TextOverflow.ellipsis,
              ),
              heightSpace,
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
              heightSpace,
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Text('Thống kê: '),
                  const Icon(Icons.thumb_up),
                  Text(' ${model.comicDetail.like}  '),
                  const Icon(FontAwesomeIcons.heart),
                  Text(' ${model.comicDetail.follow}  '),
                  const Icon(Icons.remove_red_eye),
                  Text(' ${model.comicDetail.view}')
                ],
              ),
              heightSpace,
              TypeList(
                types: model.comicDetail.types,
                findComicByType: onFindComicByType,
              ),
              ExpandablePanel(
                header: const Text(
                  "Nội dung truyện",
                  overflow: TextOverflow.ellipsis,
                ),
                headerAlignment: ExpandablePanelHeaderAlignment.center,
                collapsed: Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Text(
                    model.comicDetail.content,
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                expanded: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    model.comicDetail.content,
                    softWrap: true,
                  ),
                ),
                tapHeaderToExpand: true,
                tapBodyToCollapse: true,
                hasIcon: true,
              )
            ],
          ),
        );
      },
    );
  }
}
