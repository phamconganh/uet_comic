import 'package:provider/provider.dart';
import 'package:uet_comic/src/core/models/config.dart';
import 'package:uet_comic/src/core/services/connectivity.dart';
import 'package:uet_comic/src/core/view_models/shared/follow_dao.dart';
import 'package:uet_comic/src/core/view_models/shared/like_dow.dart';
import 'package:uet_comic/src/core/view_models/shared/search_dao.dart';
import 'package:uet_comic/src/core/view_models/views/comic_detail.dart';
import 'package:uet_comic/src/core/view_models/views/downloaded.dart';
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
      builder: (context) => LikeDao(),
    ),
    ChangeNotifierProvider(
      builder: (context) => SearchDao(),
    ),
    ChangeNotifierProvider(
      builder: (context) => SearchAppBarModel(),
    ),
    ChangeNotifierProvider(
      builder: (context) => ComicDetailPageModel(),
    ),
    ChangeNotifierProvider(
      builder: (context) => HomePageModel(),
    ),
    ChangeNotifierProvider(
      builder: (context) => DownloadedPageModel(),
    ),
    StreamProvider.value(
      value: ConnectivityService().networkStatusController.stream,
    )
  ];

  List<SingleChildCloneableWidget> dependentServices = [
    ChangeNotifierProxyProvider<FollowDao, FollowedPageModel>(
      builder: (_, followDao, __) => FollowedPageModel(followDao: followDao),
    ),
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
