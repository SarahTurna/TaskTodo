import 'package:flutter/material.dart';
import 'package:task_management/utils/enum.dart';

class WSnackbar {
  static Map<String, Color> colors = {
    'success': const Color(0xff0C7040),
    'successDark': const Color(0xff004E32),
    'warning': const Color(0xffEF8D32),
    'warningDark': const Color(0xffCC561E),
    'info': const Color(0xff0070E0),
    'infoDark': const Color(0xff05478A),
    'error': const Color(0xffC72C41),
    'errorDark': const Color(0xff801336),
  };

  static show({
    required SnackbarType type,
    required String title,
    required String description,
  }) {
    // Map SnackbarType to a specific color
    String typeKey = type.toString().split('.').last; // Get enum name
    Color backgroundColor = colors['${typeKey}'] ?? Colors.grey;
    Color darkColor = colors['${typeKey}Dark'] ?? Colors.black;

    // Create the Snackbar
    final snackBar = SnackBar(
      backgroundColor: backgroundColor,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      duration: const Duration(seconds: 3),
    );

    // Show the Snackbar
  }
}
