import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityProvider extends ChangeNotifier {
  List<ConnectivityResult> _connectivityResult = [ConnectivityResult.none];
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  bool _isChecking = false;

  List<ConnectivityResult> get connectivityResult => _connectivityResult;
  bool get isChecking => _isChecking;

  ConnectivityProvider() {
    _initConnectivity();
  }

  Future<void> _initConnectivity() async {
    Connectivity connectivity = Connectivity();
    _connectivitySubscription =
        connectivity.onConnectivityChanged.listen(_updateConnectivity);
    _updateConnectivity(await connectivity.checkConnectivity());
  }

  Future<void> _updateConnectivity(List<ConnectivityResult> result) async {
    _connectivityResult = result;
    notifyListeners();
  }

  Future<void> checkConnectivity() async {
    _isChecking = true;
    notifyListeners();
    List<ConnectivityResult> result = await Connectivity().checkConnectivity();
    _updateConnectivity(result);
    _isChecking = false;
    notifyListeners();

    if (result == [ConnectivityResult.none]) {
      throw Exception('No internet connection');
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
}
