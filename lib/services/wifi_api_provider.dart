import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WifiApiProvider {
  WifiApiProvider();

  static const platform = MethodChannel('samples.flutter.dev/battery');

  Future<String> connectWifi(String login, String password) async {
    try {
      final String result = await platform.invokeMethod(
          'getBatteryLevel', {"login": login, "password": password});

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('login', login);
      prefs.setString('password', password);

      return 'Connect with result: $result.';
    } on PlatformException catch (e) {
      return "Failed to connect. Error: $e";
    }
  }
}
