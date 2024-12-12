import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:task_management/constants/constant.dart';

class SharedPreferencesService {
  static late SharedPreferences _preferences;
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<void> saveString(String key, String? value) async {
    await _preferences.setString(key, value ?? "");
  }

  static String getString(String key) {
    return _preferences.getString(key) ?? '';
  }

  static removeToken() {
    _preferences.remove(Pkeys.token);
  }

  static Future<void> saveInt(String key, int value) async {
    await _preferences.setInt(key, value);
  }

  static int getInt(String key) {
    return _preferences.getInt(key) ?? 0;
  }

  static bool validateAccessToken() {
    final String? token = _preferences.getString(Pkeys.token);
    if (token != null) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      if (decodedToken.containsKey('exp')) {
        int expiryTimeInSeconds = decodedToken['exp'];
        int currentTimeInSeconds =
            DateTime.now().millisecondsSinceEpoch ~/ 1000;
        // Check if token has expired
        if (expiryTimeInSeconds - 20 < currentTimeInSeconds) {
          removeToken();
          return false; // Token has expired
        } else {
          return true; // Token is valid
        }
      } else {
        return true; // Token doesn't have an expiry, assume it's valid
      }
    }
    return false; // Token is null, so it's invalid
  }
}
