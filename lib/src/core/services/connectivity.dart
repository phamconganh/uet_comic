import 'dart:async';
import 'package:connectivity/connectivity.dart';

class ConnectivityService {
  static final ConnectivityService instance = ConnectivityService.internal();
  factory ConnectivityService() => instance;
  ConnectivityService.internal() {
    _networkStatusController = StreamController<ConnectivityResult>();
    _invokeNetworkStatusListen();
  }
  
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _subscription;
  StreamController<ConnectivityResult> _networkStatusController;

  StreamSubscription<ConnectivityResult> get subscription => _subscription;
  StreamController<ConnectivityResult> get networkStatusController =>
      _networkStatusController;

  // ConnectivityService()

  void _invokeNetworkStatusListen() async {
    _networkStatusController.sink.add(await _connectivity.checkConnectivity());

    _subscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _networkStatusController.sink.add(result);
    });
  }

  void disposeStreams() {
    _subscription.cancel();
    _networkStatusController.close();
  }
}
//  //The test to actually see if there is a connection
// Future<bool> checkConnection() async {
//     bool previousConnection = hasConnection;
//     try {
//         final result = await InternetAddress.lookup('google.com');
//         if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//             hasConnection = true;
//         } else {
//             hasConnection = false;
//         }
//     } on SocketException catch(_) {
//         hasConnection = false;
//     }
//     //The connection status changed send out an update to all listeners
//     if (previousConnection != hasConnection) {
//         connectionChangeController.add(hasConnection);
//     }
//     return hasConnection;
// }
