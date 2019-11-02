import 'package:provider/provider.dart';
import 'package:uet_comic/src/core/models/config.dart';
import 'package:uet_comic/src/core/services/author.dart';
import 'package:uet_comic/src/core/services/chapter.dart';
import 'package:uet_comic/src/core/services/comic.dart';
import 'package:uet_comic/src/core/services/type.dart';
// import 'package:uet_comic/src/core/services/api.dart';

List<SingleChildCloneableWidget> getProviders(Config config) {
  List<SingleChildCloneableWidget> independentServices = [
    Provider.value(
      value: config,
    ),
    Provider.value(
      value: ComicService(),
    ),
    Provider.value(
      value: ChapterService(),
    ),
    Provider.value(
      value: AuthorService(),
    ),
    Provider.value(
      value: TypeService(),
    ),
  ];

  // List<SingleChildCloneableWidget> dependentServices = [
  //   ProxyProvider<Config, Api>(
  //     builder: (context, config, api) => Api(apiURL: config.apiKey),
  //   )
  // ];

  // List<SingleChildCloneableWidget> dependentServices = [
  //   ProxyProvider<Api, AuthenticationService>(
  //     builder: (context, api, authenticationService) =>
  //         AuthenticationService(api: api),
  //   )
  // ];

  // List<SingleChildCloneableWidget> uiConsumableProviders = [
  //   StreamProvider<User>(
  //     builder: (context) => Provider.of<AuthenticationService>(context, listen: false).user,
  //   )
  // ];

  List<SingleChildCloneableWidget> providers = [
    ...independentServices,
    // ...dependentServices,
    // ...uiConsumableProviders
  ];

  return providers;
}
