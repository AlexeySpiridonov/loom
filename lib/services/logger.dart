import 'package:logger/logger.dart';
import 'package:loom/main.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

String allLogs = "";

class LoomConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    for (var line in event.lines) {
      // ignore: avoid_print
      print(line);
      allLogs += line + "\n";
    }
  }
}

class MyPrinter extends LogPrinter {
  @override
  List<String> log(LogEvent event) {
    if (debug) {
      sendWifiName(event);
    }
    return [event.message];
  }

  Future<void> sendWifiName(LogEvent event) async {
    final info = NetworkInfo();
    String? wifiName = await info.getWifiName();
    Sentry.captureMessage(event.message, params: [wifiName]);
  }
}
