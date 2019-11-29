import 'package:provider/provider.dart';
import 'package:uet_comic/src/core/models/config.dart';
import 'package:uet_comic/src/core/view_models/shared/chapter_dao.dart';
import 'package:uet_comic/src/core/view_models/shared/comic_dao.dart';
import 'package:uet_comic/src/core/view_models/shared/follow_dao.dart';
import 'package:uet_comic/src/core/view_models/shared/like_dao.dart';
import 'package:uet_comic/src/core/view_models/shared/search_dao.dart';
import 'package:uet_comic/src/core/view_models/views/account.dart';
import 'package:uet_comic/src/core/view_models/views/base.dart';
import 'package:uet_comic/src/core/view_models/views/comic_detail.dart';
import 'package:uet_comic/src/core/view_models/views/filter.dart';
import 'package:uet_comic/src/core/view_models/views/followed.dart';
import 'package:uet_comic/src/core/view_models/views/home.dart';
import 'package:uet_comic/src/core/view_models/views/search_app_bar.dart';
import 'package:uet_comic/src/core/view_models/views/settings.dart';

List<SingleChildCloneableWidget> getProviders(Config config) {
  List<SingleChildCloneableWidget> independentServices = [
    Provider.value(
      value: config,
    ),
    ChangeNotifierProvider(
      builder: (context) => ChapterDao(),
    ),
    ChangeNotifierProvider(
      builder: (context) => ComicDao(),
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
    ChangeNotifierProvider(
      builder: (context) => AccountModel(),
    ),
  ];

  List<SingleChildCloneableWidget> dependentServices = [
    ChangeNotifierProxyProvider<AccountModel, FollowDao>(
      builder: (_, accountModel, __) => FollowDao(accountModel: accountModel),
    ),
    ChangeNotifierProxyProvider<AccountModel, LikeDao>(
      builder: (_, accountModel, __) => LikeDao(accountModel: accountModel),
    ),
    ChangeNotifierProxyProvider<AccountModel, SearchDao>(
      builder: (_, accountModel, __) => SearchDao(accountModel: accountModel),
    ),
    ChangeNotifierProxyProvider<AccountModel, BasePageModel>(
      builder: (_, accountModel, __) => BasePageModel(accountModel: accountModel),
    ),
    ChangeNotifierProxyProvider<AccountModel, SettingsPageModel>(
      builder: (_, accountModel, __) => SettingsPageModel(accountModel: accountModel),
    ),
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
