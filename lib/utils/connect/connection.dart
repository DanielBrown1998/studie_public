import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class Connection {
  List<ConnectivityResult> connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  Future<void> dispose() async {
    await _connectivitySubscription.cancel();
  }

  Future<void> initializeConnection() async {
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
    debugPrint(connectionStatus.toString());
  }

  //use this if you want update you screen 
  get connectivyStream => _connectivity.onConnectivityChanged;

  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
      debugPrint(result.toString());
    } on PlatformException catch (_) {
      result = [ConnectivityResult.none];
    }

    return _updateConnectionStatus(result);
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    connectionStatus = results;
    debugPrint(connectionStatus.toString());
  }
}
