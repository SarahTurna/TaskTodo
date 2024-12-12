import 'package:flutter/material.dart';
import 'package:task_management/utils/callback.dart';
import 'package:power_state/power_state.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  //final CAuth cAuth = PowerVault.find<CAuth>();

  @override
  void initState() {
    callAfterBuild(() {
      //cAuth.checkUserState();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CircularProgressIndicator.adaptive(
        valueColor:
            AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 0, 153, 255)),
      ),
    );
  }
}
