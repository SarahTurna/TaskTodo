import 'package:flutter/material.dart';

class Pkeys {
  static const String token = "token";
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static BuildContext context = Pkeys.navigatorKey.currentContext!;
}
