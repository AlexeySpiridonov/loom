import 'package:flutter/services.dart';

class WifiApiProvider {
  WifiApiProvider();

  static const platform = MethodChannel('loom/wifi');

  Future<String> connectWifi(String login, String password) async {
    try {
      final String result = await platform.invokeMethod(
          'tryConnectToWifi', {"login": login, "password": password});
      return result;
    } on PlatformException catch (e) {
      return "Failed to connect. Error: $e";
    }
  }
}
