import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:task_management/constants/constant.dart';
import 'package:task_management/features/middleware/auth_check.dart';
import 'package:task_management/widgets/navigator.dart';
import 'package:task_management/widgets/no_internet_connection.dart';

class CInternet {
  // ignore: prefer_final_fields
  static Connectivity _connectivity = Connectivity();
  static late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  static ConnectivityResult _previousResult = ConnectivityResult.none;

  static Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    if (result != _previousResult) {
      _previousResult = result;

      if (result == ConnectivityResult.none) {
        // Check if already on NoInternetConnection page
        if (Pkeys.navigatorKey.currentState?.canPop() ?? false) {
          pushReplacementUntil(screen: const SNoInternetConnection());
        }
      } else {
        if (Pkeys.navigatorKey.currentState?.canPop() ?? false) {
          pushReplacementUntil(screen: const AuthCheck());
        }
      }
    }
  }

  static Future<void> initConnectivity() async {
    try {
      ConnectivityResult result = await _connectivity.checkConnectivity();
      if (result != _previousResult) {
        _previousResult = result;
        _updateConnectionStatus(result);
      }
    } on PlatformException catch (error) {
      print("couldn't check connectivity status $error");
    }
  }

  static initilizationAndListen() async {
    await initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }
}
