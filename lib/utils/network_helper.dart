import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:demo_project/services/connectivity_services/connectivity_bloc.dart';

class NetworkHelper {
  static void observeNetwork() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        ConnectivityBloc().add(NetworkNotify());
      } else {
        ConnectivityBloc().add(NetworkNotify(isConnected: true));
      }
    });
  }
}
