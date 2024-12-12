import 'package:flutter/material.dart';
import 'package:task_management/constants/constant.dart';

loader() {
  Navigator.push(
    Pkeys.context,
    PageRouteBuilder(
        pageBuilder: (_, __, ___) => const CircularProgressIndicator.adaptive(),
        opaque: false),
  );
}

pop() {
  Navigator.pop(Pkeys.context);
}

Future push({BuildContext? context, required Widget screen}) {
  return Navigator.push(context ?? Pkeys.context,
      MaterialPageRoute(builder: (context) => screen));
}

void pushReplacement({BuildContext? context, required Widget screen}) {
  Navigator.pushReplacement(
    context ?? Pkeys.context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}

void pushReplacementUntil({BuildContext? context, required Widget screen}) {
  Navigator.pushAndRemoveUntil(
    context ?? Pkeys.context,
    MaterialPageRoute(builder: (context) => screen),
    (route) => false,
  );
}
