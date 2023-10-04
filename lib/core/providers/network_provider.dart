import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_starter_app/core/providers/injection_provider.dart';

abstract class NetworkProvider {
  Future<bool> get isConnected;
  Stream<bool> get onConnectivityChanged;
}

class NetworkInfoImpl implements NetworkProvider {
  @override
  Future<bool> get isConnected => sl<Connectivity>()
      .checkConnectivity()
      .then((ConnectivityResult value) => value != ConnectivityResult.none);

  @override
  Stream<bool> get onConnectivityChanged => getConnectivityStream();

  getConnectivityStream() {
    final Stream<ConnectivityResult> connectivityStream =
        sl<Connectivity>().onConnectivityChanged;

    final StreamController<bool> boolStreamController =
        StreamController<bool>();

    bool? previousConnected;

    connectivityStream.listen((ConnectivityResult event) {
      final connected = (event != ConnectivityResult.none);

      if (previousConnected == null || previousConnected != connected) {
        boolStreamController.add(connected);
        previousConnected = connected;
      }
    });

    final Stream<bool> boolStream = boolStreamController.stream;
    return boolStream;
  }
}
