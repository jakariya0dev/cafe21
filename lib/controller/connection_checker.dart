
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

// Connection Checker
ConnectivityResult? connectivityResult;
late StreamSubscription<ConnectivityResult> _connectivitySubscription;

class ConnectionChecker{

  checkInternetConnection(Function widgetSetState) async {
    connectivityResult = await Connectivity().checkConnectivity();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((result) {
      connectivityResult = result;
      widgetSetState();
      // print(connectivityResult);
    });

  }
}