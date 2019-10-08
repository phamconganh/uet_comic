import 'package:provider/provider.dart';
import 'package:uet_comic/src/core/models/config.dart';
import 'package:uet_comic/src/core/services/api.dart';

List<SingleChildCloneableWidget> getProviders(Config config) {
  List<SingleChildCloneableWidget> independentServices = [
    Provider.value(value: config)
  ];

  List<SingleChildCloneableWidget> dependentServices = [
    ProxyProvider<Config, Api>(
      builder: (context, config, api) => Api(apiURL: config.apiKey),
    )
  ];

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
    ...dependentServices,
    // ...uiConsumableProviders
  ];

  return providers;
}
