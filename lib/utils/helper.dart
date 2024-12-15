import 'package:dio/dio.dart';

String getErrorMessage(dynamic e) {
  final DioException dioError = e;
  final error = dioError.response?.data;
  if (error != null) {
    // Check if the error contains a 'message' field
    if (error['message'] != null) {
      return error['message']; // Return the message field
    } else if (error['error'] != null &&
        error['error'] is Map<String, dynamic>) {
      // Access the error messages from the response data
      Map<String, dynamic> errorData = error['error'];
      String message = "";
      errorData.forEach((key, value) {
        // Concatenate error messages
        if (value is List) {
          message += '${value.join(", ")} ';
        } else {
          message += '$value ';
        }
      });
      return message.trim(); // Trim trailing whitespace
    } else {
      // Access the error messages from the response data
      Map<String, dynamic> errorData = error;
      String message = "";
      errorData.forEach((key, value) {
        // Concatenate error messages
        if (value is List) {
          message += '${value.join(", ")} ';
        } else {
          message += '$value ';
        }
      });
      return message.trim(); // Trim trailing whitespace
    }
  }
  return e?.message ?? "An error occurred"; // Fallback to DioError message
}
