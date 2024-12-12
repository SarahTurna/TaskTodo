import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:power_state/power_state.dart';
import 'package:task_management/constants/constant.dart';
import 'package:task_management/features/middleware/auth_check.dart';
import 'package:task_management/services/dio%20service/dio_service.dart';
import 'package:task_management/services/shared_preferences.dart';
import 'package:ud_design/ud_design.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //CInternet.initilizationAndListen();

  await SharedPreferencesService.init();
  DioService.create();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //restorationScopeId: "root",
      debugShowCheckedModeBanner: false,
      navigatorKey: Pkeys.navigatorKey,
      theme: ThemeData(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override

  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    checkForUpdate();
    //PowerVault.put(CAuth());
  }

  void checkForUpdate() async {
    if (Platform.isAndroid) {
      AppUpdateInfo updateStatus = await InAppUpdate.checkForUpdate();
      if (updateStatus.updateAvailability ==
          UpdateAvailability.updateAvailable) {
        await InAppUpdate.performImmediateUpdate();
      }
    } else {}
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UdDesign.init(context);
    return const Scaffold(body: AuthCheck());
  }
}
