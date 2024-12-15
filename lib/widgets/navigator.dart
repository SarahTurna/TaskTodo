import 'package:flutter/material.dart';
import 'package:task_management/constants/constant.dart';

/// Displays a loader on the screen
void loader() {
  if (Pkeys.context != null) {
    Navigator.push(
      Pkeys.context!,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
        opaque: false, // Allows the background to remain visible
      ),
    );
  } else {
    debugPrint("Pkeys.context is null. Cannot show loader.");
  }
}

/// Removes the top-most route (e.g., loader)
void pop() {
  if (Pkeys.context != null && Navigator.canPop(Pkeys.context)) {
    Navigator.pop(Pkeys.context);
  } else {
    debugPrint("Cannot pop. Either no context or nothing to pop.");
  }
}

/// Pushes a new screen onto the navigation stack
Future push({BuildContext? context, required Widget screen}) {
  final effectiveContext = context ?? Pkeys.context;
  if (effectiveContext != null) {
    return Navigator.push(
      effectiveContext,
      MaterialPageRoute(builder: (_) => screen),
    );
  } else {
    debugPrint("No valid context to push a screen.");
    return Future.value();
  }
}

/// Replaces the current screen with a new one
void pushReplacement({BuildContext? context, required Widget screen}) {
  final effectiveContext = context ?? Pkeys.context;
  if (effectiveContext != null) {
    Navigator.pushReplacement(
      effectiveContext,
      MaterialPageRoute(builder: (_) => screen),
    );
  } else {
    debugPrint("No valid context to pushReplacement.");
  }
}

/// Replaces all screens in the stack with a new one
void pushReplacementUntil({BuildContext? context, required Widget screen}) {
  final effectiveContext = context ?? Pkeys.context;
  if (effectiveContext != null) {
    Navigator.pushAndRemoveUntil(
      effectiveContext,
      MaterialPageRoute(builder: (_) => screen),
      (route) => false, // Remove all previous routes
    );
  } else {
    debugPrint("No valid context to pushReplacementUntil.");
  }
}
