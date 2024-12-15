import 'package:flutter/material.dart';

class Pkeys {
  // Keys for storing data in SharedPreferences
  static const String accessToken = "token";
  // For storing the access token
  static const String email = "email"; // For storing the user's email
  static const String password =
      "password"; // For storing the user's password (if needed)

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static BuildContext context = Pkeys.navigatorKey.currentContext!;
}
