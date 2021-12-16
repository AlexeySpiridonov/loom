import 'package:logger/logger.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

String allLogs = "";

class LoomConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    //Sentry.captureMessage(event.lines.join('\n'));
    for (var line in event.lines) {
      print(line);
      allLogs += line + "\n";
    }
  }
}

class MyPrinter extends LogPrinter {
  @override
  List<String> log(LogEvent event) {
    Sentry.captureMessage(event.message);
    return [event.message];
  }
}
