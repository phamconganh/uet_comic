import 'package:provider/provider.dart';
import 'package:uet_comic/src/core/models/config.dart';
import 'package:uet_comic/src/core/services/connectivity.dart';
import 'package:uet_comic/src/core/view_models/shared/chapter_dao.dart';
import 'package:uet_comic/src/core/view_models/shared/comic_dao.dart';
import 'package:uet_comic/src/core/view_models/shared/follow_dao.dart';
import 'package:uet_comic/src/core/view_models/shared/like_dow.dart';
import 'package:uet_comic/src/core/view_models/shared/search_dao.dart';
import 'package:uet_comic/src/core/view_models/views/base.dart';
import 'package:uet_comic/src/core/view_models/views/comic_detail.dart';
import 'package:uet_comic/src/core/view_models/views/filter.dart';
import 'package:uet_comic/src/core/view_models/views/followed.dart';
import 'package:uet_comic/src/core/view_models/views/home.dart';
import 'package:uet_comic/src/core/view_models/views/search_app_bar.dart';

List<SingleChildCloneableWidget> getProviders(Config config) {
  List<SingleChildCloneableWidget> independentServices = [
    Provider.value(
      value: config,
    ),
    ChangeNotifierProvider(
      builder: (context) => FollowDao(),
    ),
    ChangeNotifierProvider(
      builder: (context) => ChapterDao(),
    ),
    ChangeNotifierProvider(
      builder: (context) => LikeDao(),
    ),
    ChangeNotifierProvider(
      builder: (context) => SearchDao(),
    ),
    ChangeNotifierProvider(
      builder: (context) => ComicDao(),
    ),
    ChangeNotifierProvider(
      builder: (context) => BasePageModel(),
    ),
    ChangeNotifierProvider(
      builder: (context) => SearchAppBarModel(),
    ),
    ChangeNotifierProvider(
      builder: (context) => ComicDetailPageModel(),
    ),
    ChangeNotifierProvider(
      builder: (context) => FilterPageModel(),
    ),
    ChangeNotifierProvider(
      builder: (context) => HomePageModel(),
    ),
    StreamProvider.value(
      value: ConnectivityService().networkStatusController.stream,
    )
  ];

  List<SingleChildCloneableWidget> dependentServices = [
    ChangeNotifierProxyProvider<FollowDao, FollowedPageModel>(
      builder: (_, followDao, __) => FollowedPageModel(followDao: followDao),
    ),
    // ChangeNotifierProxyProvider<ComicDao, DownloadedPageModel>(
    //   builder: (_, ComicDao, __) => DownloadedPageModel(ComicDao: ComicDao),
    // ),
  ];

  // List<SingleChildCloneableWidget> uiConsumableProviders = [
  //   StreamProvider<User>(
  //     builder: (context) => Provider.of<AuthenticationService>(context, listen: false).user,
  //   )
  // ];

  List<SingleChildCloneableWidget> providers = [
    ...independentServices,
    ...dependentServices,
    // ...uiConsumableProviders
  ];

  return providers;
}
