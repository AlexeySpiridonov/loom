import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

import 'logger.dart';

class WifiApiProvider {
  WifiApiProvider();
  var logger = Logger(output: LoomConsoleOutput());

  static const platform = MethodChannel('loom/wifi');

  Future<String> connectWifi(String login, String password) async {
    try {
      final String result = await platform.invokeMethod(
          'tryConnectToWifi', {"login": login, "password": password});

      logger.i(result);
      return result;
    } on PlatformException catch (e) {
      return "Failed to connect. Error: $e";
    }
  }
}
