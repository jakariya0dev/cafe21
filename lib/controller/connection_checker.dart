
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

// referenced from here
ConnectivityResult? connectivityResult;

class ConnectionChecker{

  late StreamSubscription<ConnectivityResult> connectivitySubscription;

  checkInternetConnection(Function widgetSetState) async {
    connectivityResult = await Connectivity().checkConnectivity();
    connectivitySubscription = Connectivity().onConnectivityChanged.listen((result) {
      connectivityResult = result;
      widgetSetState();
      // print(connectivityResult);
    });

  }
}